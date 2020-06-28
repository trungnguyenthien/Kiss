//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    @discardableResult func alignStack(_ value: StackAlignment) -> Self
    @discardableResult func alignSelf(_ value: ItemAlignment) -> Self
    @discardableResult func alignItems(_ value: ItemAlignment) -> Self
}

public extension AlignmentSetter where Self: LayoutItem {
    
    func alignStack(_ value: StackAlignment) -> Self {
        self.attr.alignStack = value
        return self
    }
    
    func alignSelf(_ value: ItemAlignment) -> Self {
        self.attr.alignSelf = value
        return self
    }
    
    func alignItems(_ value: ItemAlignment) -> Self {
        self.attr.alignItems = value
        return self
    }
}
