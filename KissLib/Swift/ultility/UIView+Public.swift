//
//  UIView+Extension.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

private var kissAssociatedKey = "UIView.KissAssociatedKey"

public extension UIView {
    /// Ẩn hiện view, ngược lại với isHidden
    var isVisible: Bool {
        get { !isHidden }
        set { isHidden = !newValue }
    }

    var kiss: Kiss {
        guard let obj = objc_getAssociatedObject(self, &kissAssociatedKey) as? Kiss else {
            let newKiss = Kiss(view: self)
            objc_setAssociatedObject(self, &kissAssociatedKey, newKiss, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newKiss
        }
        return obj
    }

    class Kiss {
        let selfView: UIView
        var hasSubLayout = false

        weak var currentGroupLayout: GroupLayout?
        init(view: UIView) {
            selfView = view
        }

        public func constructIfNeed(layout: GroupLayout) {
            guard currentGroupLayout !== layout else { return }

            selfView.resetYoga()

            currentGroupLayout?.body.removeFromSuperview()
            currentGroupLayout?.resetViewHierachy()
            currentGroupLayout = layout
            currentGroupLayout?.resetViewHierachy()

            if selfView !== layout.body {
                selfView.addSubview(layout.body)
            }

            layout.constructLayout()

            layout.allOverlayGroup.forEach {
                $0.body.removeFromSuperview()
                selfView.addSubview($0.body)
            }
        }

        public var layout: UIViewLayout {
            selfView.layout
        }

        public func updateChange(width: CGFloat? = nil, height: CGFloat? = nil) {
            currentGroupLayout?.updateLayoutChange(width: width, height: height)
        }

        public func estimatedSize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
            currentGroupLayout?.estimatedSize(width: width, height: height) ?? .zero
        }

        // MARK: - VSTACK LAYOUT

        public func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
            let stack = VStackLayout()
            stack.body = selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }

        public func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
            let stack = VStackLayout()
            stack.body = selfView
            stack.layoutItems.append(builder())
            return stack
        }

        // MARK: - HSTACK LAYOUT

        public func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
            let stack = HStackLayout()
            stack.body = selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }

        public func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
            let stack = HStackLayout()
            stack.body = selfView
            stack.layoutItems.append(builder())
            return stack
        }

        // MARK: - WRAP LAYOUT

        public func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
            let stack = WrapLayout()
            stack.body = selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }

        public func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
            let stack = WrapLayout()
            stack.body = selfView
            stack.layoutItems.append(builder())
            return stack
        }
    }
}
