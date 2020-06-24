//
//  HStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class HStackLayout: GroupLayout {
    override init() {
        super.init()
        self.attr.userWidth = .grow(.max)
        self.attr.userHeight = .fit
        self.attr.userMaxHeight = .none
    }
}

extension HStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = HStackLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

func autofitHeightWithPadding(item: LayoutItem) -> Double {
    if let viewlayout = item as? UIViewLayout {
        let viewHeight = viewlayout.view?.height ?? 0.0
        return item.attr.userPaddingTop + viewHeight + item.attr.userPaddingBottom
        
    } else if let group = item as? GroupLayout {
        var maxY = 0.0
        group.layoutItems.forEach {
            let myY = $0.attr.y ?? 0
            let myHeight = $0.attr.height ?? 0
            maxY = max(maxY, myY + myHeight)
        }
        return maxY + item.attr.userPaddingBottom
    }
    return 0
}

func autofitWidthWithPadding(item: LayoutItem) -> Double {
    if let viewlayout = item as? UIViewLayout {
        let viewWidth = viewlayout.view?.width ?? 0.0
        return item.attr.userPaddingLeft + viewWidth + item.attr.userPaddingRight
        
    } else if let group = item as? GroupLayout {
        var maxX = 0.0
        group.layoutItems.forEach {
            let myX = $0.attr.x ?? 0
            let myWidth = $0.attr.width ?? 0
            maxX = max(maxX, myX + myWidth)
        }
        return maxX + item.attr.userPaddingRight
    }
    return 0
}


extension HStackLayout: LayoutArrangeAble {
    func arrangeItems(forceWidth: Double?, forceHeight: Double?) {
        attr.width = forceWidth
        attr.height = forceHeight
        
        addSpacerForAlignment(group: self)                  // For horizontal alignment
        removeStartLeadingEndTrailing()
        let hasAlign = forceWidth != nil && forceHeight != nil
        
        removeLeadingTrailingIfHasSpacer(hasAlign: hasAlign)
        makeItemsWidth()                                    // Xác định width(.value), width(.grow), xác định width(.autoFit) cho UIViewLayout
        arrangeAbleItems.forEach { // Dựa vào width đã xác định trước, arrangeItems cho fitHeight
            let item = ($0 as? LayoutItem)
            $0.arrangeItems(forceWidth: item?.attr.width , forceHeight: nil)
        }
        let lineHeight = self.makeItemsHeightWithoutPadding()
        
        arrangeAbleItems.forEach { // arrangeItems với width, height chính xác
            let item = ($0 as? LayoutItem)
            $0.arrangeItems(forceWidth: item?.attr.width , forceHeight: item?.attr.height)
        }
        
        makeItemXY(lineHeight: lineHeight, hasAlign: hasAlign)
    }
    
    private func makeItemsHeightWithoutPadding() -> Double {
        layoutItems.forEach {
            switch $0.attr.userHeight {
            case .value(let height):    $0.attr.height = height
            case .whRatio(let wh):      $0.attr.height = ($0.attr.width ?? 0) / wh
            case .fit, .grow:           $0.attr.height = autofitHeightWithPadding(item: $0)
            }
        }
        
        var fitLineHeight = 0.0
        layoutItems.forEach {
            switch $0.attr.userMaxHeight {
            case .none: ()                                  // Không tính lại, vẫn giữ height được xác định từ userHeight
            case .full: ()                                  // Sẽ xác định ở bước dưới
                
            case .value(let max):
                let devHeight = $0.attr.height ?? 0
                guard max < devHeight else { break }
                $0.attr.height = max
                
            case .fit:
                let myFitHeight = autofitHeightWithPadding(item: $0)
                let devHeight = $0.attr.height ?? 0
                guard myFitHeight < devHeight else { break }
                $0.attr.height = myFitHeight
            }
            let devHeight = $0.attr.height ?? 0
            fitLineHeight = max(fitLineHeight, devHeight)
        }
        
        layoutItems.forEach {
            switch $0.attr.userMaxHeight {
            case .none: ()                                  // Không tính lại, vẫn giữ height được xác định từ userHeight
            case .value: ()                                 // Không tính lại vì đã xác định ở trên rồi
                
            case .full:
                let devHeight = $0.attr.height ?? 0
                guard fitLineHeight < devHeight else { break }
                $0.attr.height = fitLineHeight
                
            case .fit: ()                                   // Không tính lại vì đã xác định ở trên rồi
            }
        }
        return fitLineHeight
    }
    
    private func makeItemXY(lineHeight: Double, hasAlign: Bool) {
        let itemWithOutSpacer = layoutItems.filter { !$0.isSpacer }
        let arrangeItems = hasAlign ? layoutItems : itemWithOutSpacer
        var runX = 0.0
        runX += attr.userPaddingLeft
        arrangeItems.forEach {
            let myWidth = $0.attr.width ?? 0
            let myHeight = $0.attr.height ?? 0
            $0.attr.x = runX
            runX += myWidth
            let remainSpaceY = (lineHeight - myHeight)
            switch $0.attr.userVerticalAlign {
            case .top: $0.attr.y = attr.top
            case .bottom: $0.attr.y = attr.top + remainSpaceY
            case .center: $0.attr.y = attr.top + remainSpaceY / 2
            }
        }
    }
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.leading = 0
        noSpacerLayoutItems.last?.attr.trailing = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer(hasAlign: Bool) {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.trailing = layoutItems.element(index - 1)?.attr.userTrailing ?? 0
            layoutItems.element(index + 1)?.attr.leading = layoutItems.element(index + 1)?.attr.userLeading ?? 0
            if !hasAlign {
                layoutItems.element(index - 1)?.attr.trailing = 0
                layoutItems.element(index + 1)?.attr.leading = 0
            }
        }
    }
    
    private func makeItemsWidth() {
        var sumPart = 0.0
        var remainWidth = attr.width ?? 0
        remainWidth -= attr.userPaddingLeft
        remainWidth -= attr.userPaddingRight
        
        layoutItems.enumerated().forEach { (index, item) in
            switch item.attr.userWidth {
            case .value(let fix):
                item.attr.width = fix
                remainWidth -= fix
                
            case .grow(let part):
                sumPart += part
                
            case .fit where item is GroupLayout:
                guard let group = item as? GroupLayout else { return }
                guard group.attr.width == nil else { return }
                group.arrangeAble?.arrangeItems(forceWidth: nil, forceHeight: nil)
                group.attr.width = autofitWidthWithPadding(item: group)
                remainWidth -= (item.attr.width ?? 0)
                
            case .fit:
                guard let viewLayout = item as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                viewLayout.attr.width = viewLayout.view?.width ?? 0
                viewLayout.attr.height = viewLayout.view?.height ?? 0
                remainWidth -= (item.attr.width ?? 0)
            }
            remainWidth -= item.attr.leading - item.attr.trailing
        }
        
        layoutItems.forEach {
            switch $0.attr.userWidth {
            case .grow(let part):
                let myWidth = remainWidth * part / sumPart
                $0.attr.width = myWidth
                
            case .value, .fit: ()
            }
        }
    }
}
