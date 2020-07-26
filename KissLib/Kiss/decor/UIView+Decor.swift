//
//  UIView+Decor.swift
//  Kiss
//
//  Created by Trung on 7/20/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewDecorable {
    @discardableResult func background(_ color: UIColor) -> Self
    @discardableResult func stroke(size: Double, color: UIColor) -> Self
    @discardableResult func cornerRadius(_ radius: Double) -> Self
}

extension UIView: ViewDecorable {}

public extension ViewDecorable where Self: UIView {
    @discardableResult func background(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult func stroke(size: Double, color: UIColor) -> Self {
        layer.borderWidth = CGFloat(size)
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult func cornerRadius(_ radius: Double) -> Self {
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = radius > 0
        return self
    }
}
