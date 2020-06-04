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
        self.widthValue = .value(0.5)
        self.heightValue = .fill(1)
        self.isControl = true
    }
}

extension LayoutSubviewsAble where Self: VSpacer {
    public func makeSizeSubviews(width: Double) {
        
    }
    
    public func layoutSubviews(width: Double) {
        
    }
}
