//
//  HStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class HStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
}

extension HStackLayout: LayoutArrangeAble {
    
    func applySubsWidth() {
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0) }
        var sumPart: Double = 0
        var remainWidth = expectedWidth ?? 0
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        visibledAttrs.forEach { (attr) in
            switch(attr.widthDesignValue) {
            case .value, .fit:
                let layoutArrangeAble = attr as? LayoutArrangeAble
                layoutArrangeAble?.applySelfHardSize()
            case .fillRemain(let part):
                sumPart += part
            }
            remainWidth -= attr.expectedWidth ?? 0
            remainWidth -= attr.leading - attr.trailing
        }

        visibledAttrs.forEach { (subLayout) in
            guard subLayout.expectedWidth == nil else { return }
            switch(subLayout.widthDesignValue) {
            case .value, .fit: ()
            case .fillRemain(let part):
                subLayout.expectedWidth = remainWidth * part / sumPart
            }
        }
    }

    
    func applySubsHeight() {
        
    }
    
    func applySubsFrame() {
        
    }
    
    func applySelfHeight() {
        
    }
    
    func applySubSpacers() {
        
    }
    
    func applySubsAlignments() {
        
    }
    
    
}
