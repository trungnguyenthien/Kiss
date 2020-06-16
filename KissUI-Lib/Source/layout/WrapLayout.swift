//
//  WrapLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class WrapLayout: SetViewLayout {
    override init() {
        super.init()
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
    }
    
    var lineSpacing = 0.0
    
    public func line(spacing: Double) -> Self {
        lineSpacing = spacing
        return self
    }
}
