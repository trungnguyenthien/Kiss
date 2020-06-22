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
        self.attr.userHeight = .autoFit
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
        return item.userPaddingTop + viewHeight + item.userPaddingBottom
        
    } else if let group = item as? GroupLayout {
        var maxY = 0.0
        group.layoutItems.forEach {
            let myY = $0.devY ?? 0
            let myHeight = $0.devHeight ?? 0
            maxY = max(maxY, myY + myHeight)
        }
        return maxY + item.userPaddingBottom
    }
    return 0
}

func autofitWidth(item: LayoutItem) -> Double {
    if let viewlayout = item as? UIViewLayout {
        let viewWidth = viewlayout.view?.width ?? 0.0
        return item.userPaddingLeft + viewWidth + item.userPaddingRight
        
    } else if let group = item as? GroupLayout {
        var maxX = 0.0
        group.layoutItems.forEach {
            let myX = $0.devX ?? 0
            let myWidth = $0.devWidth ?? 0
            maxX = max(maxX, myX + myWidth)
        }
        return maxX + item.userPaddingRight
    }
    return 0
}


extension HStackLayout: LayoutArrangeAble {
    func arrangeItems() {
        addSpacerForAlignment(group: self) // For horizontal alignment
        makeItemsWidth() // Xác định width(.value), width(.grow), xác định width(.autoFit) cho UIViewLayout
        arrangeAbleItems.forEach { $0.arrangeItems() } // Dựa vào width đã xác định trước, arrangeItems cho
        let lineHeight = self.lineHeightWithoutPadding()
        makeItemsHeight(lineHeight: lineHeight)
        makeItemXY(lineHeight: lineHeight)
    }
    
    private func lineHeightWithoutPadding() -> Double {
        var lineHeight = 0.0
        layoutItems.forEach {
            var myHeight = 0.0
            switch $0.userHeight {
            case .value, .whRatio: myHeight = $0.devHeight ?? 0
            case .autoFit, .grow: myHeight = autofitHeight(item: $0)
            }
            lineHeight = max(lineHeight, myHeight)
        }
        return lineHeight
    }
    
    private func makeItemXY(lineHeight: Double) {
        var runX = 0.0
        runX += userPaddingLeft
        layoutItems.forEach {
            let myWidth = $0.devWidth ?? 0
            let myHeight = $0.devHeight ?? 0
            $0.attr.devX = runX
            runX += myWidth
            let remainSpaceY = (lineHeight - myHeight)
            switch $0.userVerticalAlign {
            case .top: $0.attr.devY = userPaddingTop
            case .bottom: $0.attr.devY = userPaddingTop + remainSpaceY
            case .center: $0.attr.devY = userPaddingTop + remainSpaceY / 2
            }
        }
    }
    
    private func makeItemsHeight(lineHeight: Double) {
        layoutItems.forEach {
            let myWidth = $0.attr.devWidth ?? 0
            switch $0.userHeight {
            case .value(let fixHeight):
                $0.attr.devHeight = fixHeight
                
            case .autoFit:
                $0.attr.devHeight = autofitHeight(item: $0)
                
            case .whRatio where $0.attr.devWidth.isNil:
                throwError("")
                
            case .whRatio(let ratio):
                $0.attr.devHeight = myWidth / ratio
                
            case .grow:
                guard $0.attr.devHeight != lineHeight else { return }
                $0.attr.devHeight = lineHeight
                ($0 as? LayoutArrangeAble)?.arrangeItems()
            }
        }
    }
    
    private func makeItemsWidth() {
        var sumPart = 0.0
        var remainWidth = devWidth ?? 0
        remainWidth -= userPaddingLeft
        remainWidth -= userPaddingRight
        
        layoutItems.forEach {
            switch $0.userWidth {
            case .value(let fix):
                $0.attr.devWidth = fix
                remainWidth -= fix
                
            case .grow(let part):
                sumPart += part
                
            case .autoFit where $0 is GroupLayout:
                guard let group = $0 as? GroupLayout else { return }
                guard group.devWidth == nil else { return }
                group.arrangeAble?.arrangeItems()
                group.attr.devWidth = autofitWidth(item: group)
                remainWidth -= ($0.attr.devWidth ?? 0)
                
            case .autoFit:
                guard let viewLayout = $0 as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                viewLayout.attr.devWidth = viewLayout.view?.width ?? 0
                viewLayout.attr.devHeight = viewLayout.view?.height ?? 0
                remainWidth -= ($0.attr.devWidth ?? 0)
            }
        }
        
        layoutItems.forEach {
            switch $0.userWidth {
            case .grow(let part):
                let myWidth = remainWidth * part / sumPart
                $0.attr.devWidth = myWidth
                
            case .value, .autoFit: ()
            }
        }
    }
}
