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
        self.widthDesignValue = .grow(.max)
        self.isControl = false
    }
}

extension HStackLayout: LayoutArrangeAble {
    
    func applySubsWidth() {
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0, andSpacer: false) }
        var sumPart: Double = 0
        var remainWidth = expectedWidth ?? 0
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        visibledAttrs.forEach { (subAttr) in
            switch subAttr.widthDesignValue {
            case .value, .autoFit:
                let layoutArrangeAble = subAttr as? LayoutArrangeAble
                layoutArrangeAble?.applySelfHardSize()
                
            case .grow(let part):
                sumPart += part
            }
            remainWidth -= subAttr.expectedWidth ?? 0
            remainWidth -= subAttr.leading - subAttr.trailing
        }

        visibledAttrs.forEach { (subAttr) in
            guard subAttr.expectedWidth == nil else { return }
            switch(subAttr.widthDesignValue) {
            case .value: () // Đã được xác định ở bước trên
            case .autoFit: ()   // Đã được xác định ở bước trên
            case .grow(let part):
                let expectedWidth = remainWidth * part / sumPart
                subAttr.expectedWidth = expectedWidth
            }
        }
        applyHSpacer()
    }
    
    private func applyHSpacer() {
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0, andSpacer: true) }
        var sumPartSpacer: Double = 0
        var remainWidth = expectedWidth ?? 0
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        visibledAttrs.forEach { (subAttr) in
            let isSpacer = subAttr is HSpacer
            switch(subAttr.widthDesignValue) {
            case .value, .autoFit: ()
            case .grow(let part) where isSpacer:
                sumPartSpacer += part
            case .grow(_): ()
            }
            
            if !isSpacer {
                remainWidth -= subAttr.expectedWidth ?? 0
                remainWidth -= subAttr.leading - subAttr.trailing
            }
        }
        
        visibledAttrs.filter { $0 is HSpacer }.forEach { (hspacer) in
            switch hspacer.widthDesignValue {
            case .grow(let part):
                let expectedWidth = remainWidth * part / sumPartSpacer
                hspacer.expectedWidth = expectedWidth
                
            default: ()
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
                
            case .autoFit:
                guard subAttr.expectedHeight == nil, let size = fitSizeSetLayout(of: subAttr) else { return }
                subAttr.expectedHeight = KFloat(size.height)
                
            case .equalWidth(let hw):
                guard let expectedWidth = subAttr.expectedWidth else { return }
                subAttr.expectedHeight = expectedWidth * hw
                
            case .grow(_): // Tạm thời nó sẽ là FitSize
                guard let size = fitSizeSetLayout(of: subAttr) else { return }
                subAttr.expectedHeight = KFloat(size.height)
            }
            maxHeight = max(maxHeight, subAttr.expectedHeight ?? 0.0)
        }
        
        visibledAttrs.forEach { (subAttr) in
            switch(subAttr.heightDesignValue) {
            case .grow:
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
        let visibledAttrs = subLayouts.filter { isVisibledLayout($0) }
        var selfHeight = 0.0
        visibledAttrs.forEach { (subAttr) in
            selfHeight = max(selfHeight, subAttr.expectedHeight ?? 0)
        }
        selfHeight += paddingTop + paddingBottom
        self.expectedHeight = max(minHeight ?? 0, selfHeight)
    }
    
    func applySubSpacers() {
        // Đã xác định ở applyHSpacer
    }
    
    func applySubsAlignments() {
        
    }
    
    
}
