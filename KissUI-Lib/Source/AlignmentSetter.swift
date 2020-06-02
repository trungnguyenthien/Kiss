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

public extension AlignmentSetter where Self: LayoutAttribute {
    func align(_ vertical: VerticalAlignmentValue) -> Self {
        verticalAlignment = vertical
        return self
    }
    
    func align(_ horizontal: HorizontalAlignmentValue) -> Self {
        horizontalAlignment = horizontal
        return self
    }
}
