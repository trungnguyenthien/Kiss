//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.widthDesignValue = .grow(.max)
        self.heightDesignValue = .autoFit
    }
}

extension VStackLayout: LayoutArrangeAble {
    func addTemptSpacerIfNeed() {
        switch self.verticalAlignment {
        case .top:
            subLayouts.insert(temptSpacer, at: 0)
        
        case .bottom:
            subLayouts.append(temptSpacer)
            
        case .center:
            subLayouts.append(temptSpacer)
            subLayouts.insert(temptSpacer, at: 0)
        }
    }
    
    func startLayout() {
        
    }
    
    func applySelfHardSize() {
        
    }
    
    func applySubsWidth() {
        
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
