//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    @discardableResult func align(_ value: MainAxisAlignment) -> Self
    @discardableResult func alignSelf(_ value: CrossAxisAlignment) -> Self
    @discardableResult func alignItems(_ value: CrossAxisAlignment) -> Self
}

public extension AlignmentSetter where Self: LayoutItem {
    func align(_ value: MainAxisAlignment) -> Self {
        self.attr.alignStack = value
        return self
    }
    
    func alignSelf(_ value: CrossAxisAlignment) -> Self {
        self.attr.alignSelf = value
        return self
    }
    
    func alignItems(_ value: CrossAxisAlignment) -> Self {
        self.attr.alignItems = value
        return self
    }
}
