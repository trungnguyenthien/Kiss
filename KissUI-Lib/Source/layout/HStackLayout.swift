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

func autofitHeight(item: LayoutItem) -> Double {
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

func autofitWidth(item: LayoutItem) -> Double {
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
    func arrangeItems(draft: Bool) {
        attr.resetDevValue()
        
        addSpacerForAlignment(group: self) // For horizontal alignment
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer(draft: draft)
        makeItemsWidth() // Xác định width(.value), width(.grow), xác định width(.autoFit) cho UIViewLayout
        arrangeAbleItems.forEach { $0.arrangeItems(draft: true) } // Dựa vào width đã xác định trước, arrangeItems cho
        let lineHeight = self.fitLineHeightWithoutPadding()
//        makeItemsHeight(lineHeight: lineHeight)
        makeItemXY(lineHeight: lineHeight, draft: draft)
    }
    
    private func fitLineHeightWithoutPadding() -> Double {
        layoutItems.forEach {
            switch $0.attr.userHeight {
            case .value(let height): $0.attr.height = height
            case .whRatio(let wh): $0.attr.height = ($0.attr.width ?? 0) / wh
                
            case .fit, .grow:
                $0.attr.height = autofitHeight(item: $0)
            }
        }
        
        var fitLineHeight = 0.0
        layoutItems.forEach {
            switch $0.attr.userMaxHeight {
            case .none, .full: break
            case .value(let max):
                guard max < ($0.attr.height ?? 0) else { break }
                $0.attr.height = max
            case .fit:
                let myFitHeight = autofitHeight(item: $0)
                let devHeight = $0.attr.height ?? 0
                guard myFitHeight < devHeight else { break }
                $0.attr.height = myFitHeight
            }
            let myHeight = $0.attr.height ?? 0
            fitLineHeight = max(fitLineHeight, myHeight)
        }
        return fitLineHeight
    }
    
    private func makeItemXYForDraff(lineHeight: Double) {
        var runX = 0.0
        runX += attr.userPaddingLeft
        layoutItems.filter { !$0.isSpacer }.forEach {
            let myWidth = $0.attr.width ?? 0
            let myHeight = $0.attr.height ?? 0
            $0.attr.x = runX
            runX += myWidth
            let remainSpaceY = (lineHeight - myHeight)
            switch $0.attr.userVerticalAlign {
            case .top: $0.attr.y = attr.userTop
            case .bottom: $0.attr.y = attr.userTop + remainSpaceY
            case .center: $0.attr.y = attr.userTop + remainSpaceY / 2
            }
        }
    }
    
    private func makeItemXY(lineHeight: Double, draft: Bool) {
        if draft {
            makeItemXYForDraff(lineHeight: lineHeight)
            return
        }
        
        var runX = 0.0
        runX += attr.userPaddingLeft
        layoutItems.forEach {
            let myWidth = $0.attr.width ?? 0
            let myHeight = $0.attr.height ?? 0
            $0.attr.x = runX
            runX += myWidth
            let remainSpaceY = (lineHeight - myHeight)
            switch $0.attr.userVerticalAlign {
            case .top: $0.attr.y = attr.userTop
            case .bottom: $0.attr.y = attr.userTop + remainSpaceY
            case .center: $0.attr.y = attr.userTop + remainSpaceY / 2
            }
        }
    }
    
    private func makeItemsHeight(lineHeight: Double) {
        layoutItems.forEach {
            let myWidth = $0.attr.width ?? 0
            switch $0.attr.userHeight {
            case .value(let fixHeight):
                $0.attr.height = fixHeight
                
            case .fit:
                $0.attr.height = autofitHeight(item: $0)
                
            case .whRatio where $0.attr.width.isNil:
                throwError("")
                
            case .whRatio(let ratio):
                $0.attr.height = myWidth / ratio
                
            case .grow:
                guard $0.attr.height != lineHeight else { return }
                $0.attr.height = lineHeight
                ($0 as? LayoutArrangeAble)?.arrangeItems(draft: true)
            }
        }
    }
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.leading = 0
        noSpacerLayoutItems.last?.attr.trailing = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer(draft: Bool) {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.trailing = layoutItems.element(index - 1)?.attr.userTrailing ?? 0
            layoutItems.element(index + 1)?.attr.leading = layoutItems.element(index + 1)?.attr.userLeading ?? 0
            if draft {
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
                group.arrangeAble?.arrangeItems(draft: true)
                group.attr.width = autofitWidth(item: group)
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
