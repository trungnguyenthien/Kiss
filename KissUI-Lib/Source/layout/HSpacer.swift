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
        self.heightValue = .value(0.5)
        self.widthValue = .fill(1)
        self.isControl = true
    }
}

extension LayoutSubviewsAble where Self: HSpacer {
    public func makeSizeSubviews(width: Double) {
        
    }
    
    public func layoutSubviews(width: Double) {
        
    }
}
