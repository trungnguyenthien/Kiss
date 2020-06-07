//
//  VSpacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VSpacer: LayoutAttribute {
    override init() {
        super.init()
        self.widthDesignValue = .value(0.5)
        self.heightDesignValue = .fillRemain(1)
        self.isControl = true
    }
    
    public override func makeSizeSubviews(width: Double) {
        
    }
    
    public override func layoutSubviews(width: Double) {
        
    }
}
