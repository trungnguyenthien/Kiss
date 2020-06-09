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
        
        visibledAttrs.forEach { (subAttr) in
            switch(subAttr.widthDesignValue) {
            case .value, .fit:
                let layoutArrangeAble = subAttr as? LayoutArrangeAble
                layoutArrangeAble?.applySelfHardSize()
                
            case .fillRemain(let part):
                sumPart += part
            }
            remainWidth -= subAttr.expectedWidth ?? 0
            remainWidth -= subAttr.leading - subAttr.trailing
        }

        visibledAttrs.forEach { (subAttr) in
            guard subAttr.expectedWidth == nil else { return }
            switch(subAttr.widthDesignValue) {
            case .value: () // Đã được xác định ở bước trên
            case .fit: ()   // Đã được xác định ở bước trên
            case .fillRemain(let part):
                subAttr.expectedWidth = remainWidth * part / sumPart
            }
        }
    }

    /*
     2.applySubsWidth
     3.sub.startLayout
     4.applySubsHeight
     */
    func applySubsHeight() {
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0) }
        var maxHeight = 0.0
        visibledAttrs.forEach { (subAttr) in
            switch(subAttr.heightDesignValue) {
            case .value: () // Đã được xác định trong applySelfHardSize ở bước applySubsWidth
                
            case .fit:
                guard subAttr.expectedHeight == nil, let size = fitSize(of: subAttr) else { return }
                subAttr.expectedHeight = KFloat(size.height)
                
            case .equalWidth(let hw):
                guard let expectedWidth = subAttr.expectedWidth else { return }
                subAttr.expectedHeight = expectedWidth * hw
                
            case .fillRemain(_): // Tạm thời nó sẽ là FitSize
                guard let size = fitSize(of: subAttr) else { return }
                subAttr.expectedHeight = KFloat(size.height)
            }
            maxHeight = max(maxHeight, subAttr.expectedHeight ?? 0.0)
        }
        
        visibledAttrs.forEach { (subAttr) in
            switch(subAttr.heightDesignValue) {
            case .fillRemain:
                printWarning("Item trong HStack thì việc gán height(.fillRemain) tương đương height(.fullLine)")
                subAttr.expectedHeight = maxHeight
                
            default: ()
            }
        }
    }
    
    func applySubsFrame() {
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0) }
        var runX = expectedX ?? 0
        var selfY = expectedY ?? 0
        runX -= paddingLeft
        selfY -= paddingTop
        var maxHeight = 0.0
        
        visibledAttrs.enumerated().forEach { (index, subAttr) in
            if index != 0 {
                runX -= subAttr.leading
            }
            subAttr.expectedX = runX
            subAttr.expectedY = selfY
            let subWidth = subAttr.expectedWidth ?? 0.0
            runX = runX - subWidth - subAttr.trailing
        }
    }
    
    func applySelfHeight() {
        
    }
    
    func applySubSpacers() {
        
    }
    
    func applySubsAlignments() {
        
    }
    
    
}
