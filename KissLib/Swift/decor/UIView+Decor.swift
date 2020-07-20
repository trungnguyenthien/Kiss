//
//  UIView+Decor.swift
//  Kiss
//
//  Created by Trung on 7/20/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewDecorator {
    @discardableResult func background(color: UIColor) -> Self
    @discardableResult func stroke(size: Double) -> Self
    @discardableResult func stroke(color: UIColor) -> Self
    @discardableResult func cornerRadius(_ radius: Double) -> Self
    @discardableResult func corners(_ corners: UIRectCorner, radius: Double) -> Self
}

extension UIView: ViewDecorator {}

public extension ViewDecorator where Self: UIView {
    @discardableResult func background(color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult func stroke(size: Double) -> Self {
        layer.borderWidth = CGFloat(size)
        return self
    }

    @discardableResult func stroke(color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult func cornerRadius(_ radius: Double) -> Self {
        corners(.allCorners, radius: radius)
        return self
    }

    @discardableResult func corners(_ corners: UIRectCorner, radius: Double) -> Self {
        // https://www.swiftdevcenter.com/uiview-round-specific-corners-only-swift/
        let size = CGSize(width: radius, height: radius)
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
        return self
    }
}
