//
//  SizeSetter.swift
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol SizeSetter {
    @discardableResult func width(_ value: Double) -> Self
    @discardableResult func height(_ value: Double) -> Self

    @discardableResult func grow(_ value: Double) -> Self
    @discardableResult func growFull() -> Self
    @discardableResult func ratio(_ value: Double) -> Self

    @discardableResult func size(_ value: CGSize) -> Self
    @discardableResult func size(_ width: Double, _ height: Double) -> Self

    @discardableResult func maxHeight(_ value: Double) -> Self
    @discardableResult func minHeight(_ value: Double) -> Self

    @discardableResult func maxWidth(_ value: Double) -> Self
    @discardableResult func minWidth(_ value: Double) -> Self
}

public extension SizeSetter where Self: LayoutItem {
    func ratio(_ value: Double) -> Self {
        attr.ratio = value
        return self
    }

    func grow(_ value: Double) -> Self {
        attr.grow = value
        return self
    }

    func growFull() -> Self {
        attr.grow = -.sameZero
        return self
    }

    func size(_ value: CGSize) -> Self {
        attr.userWidth = Double(value.width)
        attr.userHeight = Double(value.height)
        return self
    }

    func size(_ width: Double, _ height: Double) -> Self {
        attr.userWidth = width
        attr.userHeight = height
        return self
    }

    func width(_ value: Double) -> Self {
        attr.userWidth = value
        return self
    }

    func height(_ value: Double) -> Self {
        attr.userHeight = value
        return self
    }

    func maxHeight(_ value: Double) -> Self {
        attr.maxHeight = value
        return self
    }

    func minHeight(_ value: Double) -> Self {
        attr.minHeight = value
        return self
    }

    func maxWidth(_ value: Double) -> Self {
        attr.maxWidth = value
        return self
    }

    func minWidth(_ value: Double) -> Self {
        attr.minWidth = value
        return self
    }
}
