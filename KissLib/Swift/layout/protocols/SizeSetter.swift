
import Foundation
import UIKit

// -------------

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

extension SizeSetter where Self: LayoutItem {
    public func ratio(_ value: Double) -> Self {
        attr.ratio = value
        return self
    }

    public func grow(_ value: Double) -> Self {
        attr.grow = value
        return self
    }

    public func growFull() -> Self {
        attr.grow = -.sameZero
        return self
    }

    public func size(_ value: CGSize) -> Self {
        attr.userWidth = Double(value.width)
        attr.userHeight = Double(value.height)
        return self
    }

    public func size(_ width: Double, _ height: Double) -> Self {
        attr.userWidth = width
        attr.userHeight = height
        return self
    }

    public func width(_ value: Double) -> Self {
        attr.userWidth = value
        return self
    }

    public func height(_ value: Double) -> Self {
        attr.userHeight = value
        return self
    }

    public func maxHeight(_ value: Double) -> Self {
        attr.maxHeight = value
        return self
    }

    public func minHeight(_ value: Double) -> Self {
        attr.minHeight = value
        return self
    }

    public func maxWidth(_ value: Double) -> Self {
        attr.maxWidth = value
        return self
    }

    public func minWidth(_ value: Double) -> Self {
        attr.minWidth = value
        return self
    }
}
