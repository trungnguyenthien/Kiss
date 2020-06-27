//
//  AnchorSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public protocol MarginSetter {
    @discardableResult func leading(_ value: Double) -> Self
    @discardableResult func trailing(_ value: Double) -> Self
    @discardableResult func top(_ value: Double) -> Self
    @discardableResult func bottom(_ value: Double) -> Self
}

public extension MarginSetter where Self: LayoutItem {
    func leading(_ value: Double) -> Self {
        attr.userLeading = value
        attr.mLeft = value
        return self
    }
    
    func trailing(_ value: Double) -> Self {
        attr.userTrailing = value
        attr.mRight = value
        return self
    }
    
    func top(_ value: Double) -> Self {
        attr.userTop = value
        attr.mTop = value
        return self
    }
    
    func bottom(_ value: Double) -> Self {
        attr.userBottom = value
        attr.mBottom = value
        return self
    }
}
