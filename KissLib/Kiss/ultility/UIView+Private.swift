//
//  UIView+Private.swift
//
//  Created by Trung on 7/15/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

extension Sequence where Element: UIView {
    func removeFromCurrentSuperview() { forEach { $0.removeFromSuperview() } }
}

extension UIView {
    func addSubviews(inLayout layout: GroupLayout) {
        layout.uiContentViews.removeFromCurrentSuperview()
        layout.uiContentViews.forEach { addSubview($0) }
    }

    // MARK: - VIEWLAYOUT

    var layout: UIViewLayout {
        // Nếu là custom view đã có sẵn layout rồi thì sử dụng bản copy của custom view đó

        let vlayout = UIViewLayout()
        vlayout.body = self
        return vlayout
    }

    func applyLayoutFlexibleAll(preservingOrigin: Bool) {
        let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleHeight, .flexibleWidth)
        yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
    }

    func applyLayout(preservingOrigin: Bool, fixWidth: CGFloat?, fixHeight: CGFloat?) {
        if let width = fixWidth, let height = fixHeight {
            configureLayout { yLayout in
                yLayout.width = YGValue(width)
                yLayout.height = YGValue(height)
            }
            yoga.applyLayout(preservingOrigin: preservingOrigin)
        } else if let width = fixWidth, fixHeight == nil {
            configureLayout { yLayout in
                yLayout.width = YGValue(width)
                yLayout.height = YGValueAuto
            }
            let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleHeight)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
        } else if let height = fixHeight, fixWidth == nil {
            configureLayout { yLayout in
                yLayout.width = YGValueAuto
                yLayout.height = YGValue(height)
            }
            let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleWidth)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
        } else {
            configureLayout { yLayout in
                yLayout.width = YGValueAuto
                yLayout.height = YGValueAuto
            }
            let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleWidth, .flexibleHeight)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
        }
    }

    func convertedFrame(subview: UIView) -> CGRect? {
        guard subview.isDescendant(of: self) else { return nil }

        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }

        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            guard let superSuper = superview?.superview else { break }
            superview = superSuper
        }

        return superview!.convert(frame, to: self)
    }
}
