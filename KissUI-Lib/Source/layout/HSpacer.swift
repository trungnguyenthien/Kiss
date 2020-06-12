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
        self.heightDesignValue = .value(.sameZero)
        self.widthDesignValue = .grow(.sameZero)
        self.isControl = true
    }
    
}
