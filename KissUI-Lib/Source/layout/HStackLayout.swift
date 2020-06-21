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
        group.layoutItems.compactMap { $0 as? UIViewLayout }.forEach {
            let myMaxY = ($0.expectedY ?? 0) + ($0.expectedHeight ?? 0)
            maxY = max(maxY, myMaxY)
        }
        return maxY + item.paddingBottom
    }
    return 0
}


extension HStackLayout: LayoutArrangeAble {
    func arrangeItems() {
        addSpacerForAlignment(group: self)
        makeItemsWidth()
        
        arrangeAbleItems.forEach { $0.arrangeItems() }
        makeItemsFitHeight(lineHeight: lineHeight())
        makeItemXY()
    }
    
    private func lineHeight() -> Double {
        var lineHeight = 0.0
        layoutItems.forEach {
            let myHeight = $0.expectedHeight ?? autofitHeight(item: $0)
            lineHeight = max(lineHeight, myHeight)
        }
        return lineHeight
    }
    
    private func makeItemXY() {
        var runX = 0.0
        var runY = 0.0
        var lineHeight = 0.0
        var isInvalidate = false
        runX += paddingLeft
        layoutItems.forEach {
            let myWidth = $0.expectedWidth ?? 0
            let myHeight = $0.expectedHeight ?? autofitHeight(item: $0)
            
            $0.attr.expectedX = runX
            runX += myWidth
            lineHeight = max(lineHeight, myHeight)
        }
        
        layoutItems.forEach {
            switch $0.heightDesignValue {
            case .grow:
                let fitHeight = autofitHeight(item: $0)
                if $0.expectedHeight != fitHeight {
                    $0.attr.expectedHeight = fitHeight
                    ($0 as? LayoutArrangeAble)?.arrangeItems()
                }
                
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
        }
    }
    
    private func makeItemsFitHeight(lineHeight: Double) {
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
                if $0.attr.expectedHeight != lineHeight {
                    $0.attr.expectedHeight = lineHeight
                    ($0 as? LayoutArrangeAble)?.arrangeItems()
                }
                
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
                
            case .autoFit:
                if let viewLayout = $0 as? UIViewLayout {
                    viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                    $0.attr.expectedWidth = viewLayout.view?.width ?? 0
                    $0.attr.expectedHeight = viewLayout.view?.height ?? 0
                    remainWidth -= ($0.attr.expectedWidth ?? 0)
                } else if $0 is GroupLayout {
                    throwError("Thuộc tính width(.autoFit) chỉ dành cho UIViewLayout")
                }
            }
        }
        
        layoutItems.forEach {
            switch $0.widthDesignValue {
            case .grow(let part):
                let myWidth = remainWidth * part / sumPart
                $0.attr.expectedWidth = myWidth
                
            case .value(_): ()
            case .autoFit: ()
            }
        }
    }
}
