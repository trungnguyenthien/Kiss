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
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
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
        return item.paddingTop + viewHeight + item.paddingBottom
        
    } else if let group = item as? GroupLayout {
        var maxY = 0.0
        group.layoutItems.forEach {
            let myY = $0.expectedY ?? 0
            let myHeight = $0.expectedHeight ?? 0
            maxY = max(maxY, myY + myHeight)
        }
        return maxY + item.paddingBottom
    }
    return 0
}

func autofitWidth(item: LayoutItem) -> Double {
    if let viewlayout = item as? UIViewLayout {
        let viewWidth = viewlayout.view?.width ?? 0.0
        return item.paddingLeft + viewWidth + item.paddingRight
        
    } else if let group = item as? GroupLayout {
        var maxX = 0.0
        group.layoutItems.forEach {
            let myX = $0.expectedX ?? 0
            let myWidth = $0.expectedWidth ?? 0
            maxX = max(maxX, myX + myWidth)
        }
        return maxX + item.paddingRight
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
            switch $0.heightDesignValue {
            case .value, .whRatio: myHeight = $0.expectedHeight ?? 0
            case .autoFit, .grow: myHeight = autofitHeight(item: $0)
            }
            lineHeight = max(lineHeight, myHeight)
        }
        return lineHeight
    }
    
    private func makeItemXY(lineHeight: Double) {
        var runX = 0.0
        runX += paddingLeft
        layoutItems.forEach {
            let myWidth = $0.expectedWidth ?? 0
            let myHeight = $0.expectedHeight ?? 0
            $0.attr.expectedX = runX
            runX += myWidth
            let remainSpaceY = (lineHeight - myHeight)
            switch $0.verticalAlignment {
            case .top: $0.attr.expectedY = paddingTop
            case .bottom: $0.attr.expectedY = paddingTop + remainSpaceY
            case .center: $0.attr.expectedY = paddingTop + remainSpaceY / 2
            }
        }
    }
    
    private func makeItemsHeight(lineHeight: Double) {
        layoutItems.forEach {
            let myWidth = $0.attr.expectedWidth ?? 0
            switch $0.heightDesignValue {
            case .value(let fixHeight):
                $0.attr.expectedHeight = fixHeight
                
            case .autoFit:
                $0.attr.expectedHeight = autofitHeight(item: $0)
                
            case .whRatio where $0.attr.expectedWidth.isNil:
                throwError("")
                
            case .whRatio(let ratio):
                $0.attr.expectedHeight = myWidth / ratio
                
            case .grow:
                guard $0.attr.expectedHeight != lineHeight else { return }
                $0.attr.expectedHeight = lineHeight
                ($0 as? LayoutArrangeAble)?.arrangeItems()
            }
        }
    }
    
    private func makeItemsWidth() {
        var sumPart = 0.0
        var remainWidth = expectedWidth ?? 0
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        layoutItems.forEach {
            switch $0.widthDesignValue {
            case .value(let fix):
                $0.attr.expectedWidth = fix
                remainWidth -= fix
                
            case .grow(let part):
                sumPart += part
                
            case .autoFit where $0 is GroupLayout:
                guard let group = $0 as? GroupLayout else { return }
                guard group.expectedWidth == nil else { return }
                group.arrangeAble?.arrangeItems()
                group.attr.expectedWidth = autofitWidth(item: group)
                remainWidth -= ($0.attr.expectedWidth ?? 0)
                
            case .autoFit:
                guard let viewLayout = $0 as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                viewLayout.attr.expectedWidth = viewLayout.view?.width ?? 0
                viewLayout.attr.expectedHeight = viewLayout.view?.height ?? 0
                remainWidth -= ($0.attr.expectedWidth ?? 0)
            }
        }
        
        layoutItems.forEach {
            switch $0.widthDesignValue {
            case .grow(let part):
                let myWidth = remainWidth * part / sumPart
                $0.attr.expectedWidth = myWidth
                
            case .value, .autoFit: ()
            }
        }
    }
}
