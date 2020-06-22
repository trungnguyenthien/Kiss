//
//  AnchorSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public protocol EdgeSetter {
    @discardableResult func leading(_ value: Double) -> Self
    @discardableResult func trailing(_ value: Double) -> Self
    @discardableResult func top(_ value: Double) -> Self
    @discardableResult func bottom(_ value: Double) -> Self
}

public extension EdgeSetter where Self: LayoutItem {
    func leading(_ value: Double) -> Self {
        attr.leading = value
        return self
    }
    
    func trailing(_ value: Double) -> Self {
        attr.trailing = value
        return self
    }
    
    func top(_ value: Double) -> Self {
        attr.top = value
        return self
    }
    
    func bottom(_ value: Double) -> Self {
        attr.bottom = value
        return self
    }
}
