//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    func vAlign(_ value: VerticalAlignmentValue) -> Self
    func hAlign(_ value: HorizontalAlignmentValue) -> Self
}

public extension AlignmentSetter where Self: LayoutAttribute {
    func vAlign(_ value: VerticalAlignmentValue) -> Self {
        verticalAlignment = value
        return self
    }
    
    func hAlign(_ value: HorizontalAlignmentValue) -> Self {
        horizontalAlignment = value
        return self
    }
}
