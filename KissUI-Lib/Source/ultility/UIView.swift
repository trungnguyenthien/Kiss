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

public extension UIView {
    // MARK: - VSTACK LAYOUT
    func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
        let stack = VStackLayout()
        stack.body = self
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
        let stack = VStackLayout()
        stack.body = self
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - HSTACK LAYOUT
    func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
        let stack = HStackLayout()
        stack.body = self
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
        let stack = HStackLayout()
        stack.body = self
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - WRAP LAYOUT
    func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
        let stack = WrapLayout()
        stack.body = self
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
        let stack = WrapLayout()
        stack.body = self
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - VIEWLAYOUT
    var layout: UIViewLayout {
        let vlayout = UIViewLayout()
        vlayout.body = self
        return vlayout
    }
}


extension UIView {
    var x: Double {
        get { Double(frame.origin.x) }
        set { frame.origin.x = CGFloat(newValue) }
    }
    
    var y: Double {
        get { Double(frame.origin.y) }
        set { frame.origin.y = CGFloat(newValue) }
    }
    
    var height: Double {
        get { Double(frame.height) }
        set { frame.size = CGSize(width: width, height: newValue) }
    }
    
    var width: Double {
        get { Double(frame.width) }
        set { frame.size = CGSize(width: newValue, height: height) }
    }
    
    func shift(dx: Double = 0, dy: Double = 0) {
        x += dx
        y += dy
    }
    
    func applyLayoutFlexibleAll(preservingOrigin: Bool) {
        yoga.applyLayout(preservingOrigin: preservingOrigin,
                         dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleHeight, .flexibleWidth))
    }
    
    func applyLayout(preservingOrigin: Bool, fixWidth: CGFloat?, fixHeight: CGFloat?) {
        if let width = fixWidth, let height = fixHeight {
            yoga.width = YGValue(width)
            yoga.height = YGValue(height)
            yoga.applyLayout(preservingOrigin: preservingOrigin)
        } else if let width = fixWidth, fixHeight == nil {
            yoga.width = YGValue(width)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleHeight))
        } else if let height = fixHeight, fixWidth == nil {
            yoga.height = YGValue(height)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleWidth))
        } else {
            yoga.width = YGValueUndefined
            yoga.height = YGValueUndefined
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleWidth, .flexibleHeight))
        }
    }
}

var kissKey = "UIView.kiss"
extension UIView {
    
    public var kiss: Kiss {
        get {
            guard let obj = objc_getAssociatedObject(self, &kissKey) as? Kiss else {
                let newKiss = Kiss(view: self)
                objc_setAssociatedObject(self, &kissKey, newKiss, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newKiss
            }
            return obj
        }
    }
    
    public class Kiss {
        let view: UIView
        weak var currentGroupLayout: GroupLayout? = nil
        init(view: UIView) {
            self.view = view
        }
        
        public func constructIfNeed(layout: GroupLayout) {
            if currentGroupLayout === layout { return }
            currentGroupLayout = layout

            view.subviews.forEach { $0.removeFromSuperview() }
            layout.layerViews.forEach {
                $0.removeFromSuperview()
                view.addSubview($0)
            }
            layout.constructLayout()
        }
        
        public func updateChange(width: CGFloat? = nil, height: CGFloat? = nil) {
            currentGroupLayout?.updateLayoutChange(width: width, height: height)
        }
        
        public func estimatedSize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
            return currentGroupLayout?.estimatedSize(width: width, height: height) ?? .zero
        }
    }
}
