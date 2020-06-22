//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VStackLayout: GroupLayout {
    override init() {
        super.init()
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
    }
}

extension VStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = VStackLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

extension VStackLayout: LayoutArrangeAble {
    func arrangeItems() {
        addSpacerForAlignment(group: self) // For vertical alignment
        makeItemsWidth() //
        arrangeAbleItems.forEach { $0.arrangeItems() } // Dựa vào width đã xác định trước, arrangeItems cho
        makeItemsHeight()
        makeItemXY()
    }
    
    func makeItemXY() {
        var runY = 0.0
        runY += paddingTop
        layoutItems.forEach {
            let myWidth = $0.expectedWidth ?? 0
            let myHeight = $0.expectedHeight ?? 0
            $0.attr.expectedY = runY
            runY += myHeight
            let remainSpaceX = (expectedWidth ?? 0) - myWidth - paddingLeft - paddingRight
            switch $0.horizontalAlignment {
                
            case .left:     $0.attr.expectedX = paddingRight
            case .right:    $0.attr.expectedX = paddingRight + remainSpaceX
            case .center:   $0.attr.expectedX = paddingRight + remainSpaceX / 2
            }
        }
    }
    
    private func makeItemsHeight() {
        var remainHeight = expectedHeight ?? 0
        remainHeight -= paddingTop
        remainHeight -= paddingBottom
        var sumPart = 0.0
        layoutItems.forEach {
            switch $0.heightDesignValue {
            case .value(let fixHeight):
                $0.attr.expectedHeight = fixHeight
                remainHeight -= $0.attr.expectedHeight ?? 0
                
            case .autoFit:
                $0.attr.expectedHeight = autofitHeight(item: $0)
                remainHeight -= $0.attr.expectedHeight ?? 0
                
            case .whRatio where $0.attr.expectedWidth.isNil:
                throwError("Thuộc tính height(.ratio) không khả dụng nếu width không thể xác định")
                
            case .whRatio(let ratio):
                let myWidth = $0.attr.expectedWidth ?? 0
                $0.attr.expectedHeight = myWidth / ratio
                remainHeight -= $0.attr.expectedHeight ?? 0
                
            case .grow(let part):
                sumPart += part
            }
        }
        
        layoutItems.forEach {
            switch $0.heightDesignValue {
            case .value, .autoFit,.whRatio: break
            case .grow(let part):
                $0.attr.expectedHeight = remainHeight * part / sumPart
            }
        }
        
    }
    
    private func makeItemsWidth() {
        var remainWidth = expectedWidth ?? 0
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        layoutItems.forEach {
            switch $0.widthDesignValue {
            case .value(let fix):
                $0.attr.expectedWidth = fix
                
            case .grow(let part):
                if part != .max { printWarning("Thuộc tính width(.grow) trong VStack không khả dụng, sẽ đưa về width(.full)") }
                $0.attr.widthDesignValue = .grow(.max)
                $0.attr.expectedWidth = remainWidth
                
            case .autoFit where $0 is GroupLayout:
                guard let group = $0 as? GroupLayout else { return }
                guard group.expectedWidth == nil else { return }
                group.arrangeAble?.arrangeItems()
                group.attr.expectedWidth = autofitWidth(item: group)
                
            case .autoFit:
                guard let viewLayout = $0 as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                $0.attr.expectedWidth = viewLayout.view?.width ?? 0
                $0.attr.expectedHeight = viewLayout.view?.height ?? 0
            }
        }
    }
}
