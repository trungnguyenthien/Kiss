//
//  AnchorSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public protocol MarginSetter {
    @discardableResult func marginLeft(_ value: Double) -> Self
    @discardableResult func marginRight(_ value: Double) -> Self
    @discardableResult func marginTop(_ value: Double) -> Self
    @discardableResult func marginBottom(_ value: Double) -> Self
}

public extension MarginSetter where Self: LayoutItem {
    func marginLeft(_ value: Double) -> Self {
        attr.userMarginLeft = value
        attr.mLeft = value
        return self
    }
    
    func marginRight(_ value: Double) -> Self {
        attr.userMarginRight = value
        attr.mRight = value
        return self
    }
    
    func marginTop(_ value: Double) -> Self {
        attr.userMarginTop = value
        attr.mTop = value
        return self
    }
    
    func marginBottom(_ value: Double) -> Self {
        attr.userMarginBottom = value
        attr.mBottom = value
        return self
    }
}
