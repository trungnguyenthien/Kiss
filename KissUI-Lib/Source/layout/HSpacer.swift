//
//  HSpacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class HSpacer: LayoutAttribute {
    override init() {
        super.init()
        self.heightDesignValue = .value(0.5)
        self.widthDesignValue = .fill(1)
        self.isControl = true
    }
    
    public override func makeSizeSubviews(width: Double) {
        
    }
    
    public override func layoutSubviews(width: Double) {
        
    }
}
