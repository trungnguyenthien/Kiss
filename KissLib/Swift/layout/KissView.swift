//
//  KissView.swift
//  Kiss
//
//  Created by Trung on 7/5/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

open class KissView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }

    override public var intrinsicContentSize: CGSize {
        return kiss.estimatedSize()
    }

    override open func sizeToFit() {
        kiss.updateChange()
    }

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return kiss.estimatedSize(width: size.width, height: size.height)
    }
}
