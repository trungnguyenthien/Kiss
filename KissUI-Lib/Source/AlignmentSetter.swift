//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    func align(_ vertical: VerticalAlignmentValue) -> Self
    func align(_ horizontal: HorizontalAlignmentValue) -> Self
}

extension AlignmentSetter where Self: LayoutAttribute {
    public func align(_ vertical: VerticalAlignmentValue) -> Self {
        verticalAlignment = vertical
        return self
    }
    
    public func align(_ horizontal: HorizontalAlignmentValue) -> Self {
        horizontalAlignment = horizontal
        return self
    }
}
