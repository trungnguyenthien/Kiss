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

    @discardableResult func marginHorizontal(_ value: Double) -> Self
    @discardableResult func marginVertical(_ value: Double) -> Self
    @discardableResult func margin(_ value: Double) -> Self
}

public extension MarginSetter where Self: LayoutItem {
    func marginLeft(_ value: Double) -> Self {
        attr.userMarginLeft = value
        attr.forcedLeft = value
        return self
    }

    func marginRight(_ value: Double) -> Self {
        attr.userMarginRight = value
        attr.forcedRight = value
        return self
    }

    func marginTop(_ value: Double) -> Self {
        attr.userMarginTop = value
        attr.forcedTop = value
        return self
    }

    func marginBottom(_ value: Double) -> Self {
        attr.userMarginBottom = value
        attr.forcedBottom = value
        return self
    }

    func marginHorizontal(_ value: Double) -> Self {
        marginLeft(value)
        marginRight(value)
        return self
    }

    func marginVertical(_ value: Double) -> Self {
        marginTop(value)
        marginBottom(value)
        return self
    }

    func margin(_ value: Double) -> Self {
        marginVertical(value)
        marginHorizontal(value)
        return self
    }
}
