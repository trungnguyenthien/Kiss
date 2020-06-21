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

extension HStackLayout: LayoutArrangeAble {
    func arrangeItems() {
        add_spacer_To_SelfLayout_For_AutoAlignment(group: self)
        makeItemsWidth()
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
                }
                if $0 is GroupLayout {
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
