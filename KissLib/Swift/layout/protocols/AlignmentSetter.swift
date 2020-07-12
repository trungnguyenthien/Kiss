//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    @discardableResult func mainAlign(_ value: MainAxisAlignment) -> Self
    @discardableResult func crossAlign(self value: CrossAxisAlignment) -> Self
    @discardableResult func crossAlign(items value: CrossAxisAlignment) -> Self
}

public extension AlignmentSetter where Self: LayoutItem {
    func mainAlign(_ value: MainAxisAlignment) -> Self {
        self.attr.alignStack = value
        return self
    }
    
    func crossAlign(self value: CrossAxisAlignment) -> Self {
        self.attr.alignSelf = value
        return self
    }
    
    func crossAlign(items value: CrossAxisAlignment) -> Self {
        self.attr.alignItems = value
        return self
    }
}
