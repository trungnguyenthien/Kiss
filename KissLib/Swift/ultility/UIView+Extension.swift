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
    // MARK: - VIEWLAYOUT
    internal var layout: UIViewLayout {
        // Nếu là custom view đã có sẵn layout rồi thì sử dụng bản copy của custom view đó
        
        let vlayout = UIViewLayout()
        vlayout.body = self
        return vlayout
    }
    
    /// Ẩn hiện view, ngược lại với isHidden
    var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
}


extension UIView {
    func applyLayoutFlexibleAll(preservingOrigin: Bool) {
        let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleHeight, .flexibleWidth)
        yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
    }
    
    func applyLayout(preservingOrigin: Bool, fixWidth: CGFloat?, fixHeight: CGFloat?) {
        if let width = fixWidth, let height = fixHeight {
            configureLayout { (l) in
                l.width = YGValue(width)
                l.height = YGValue(height)
            }
            yoga.applyLayout(preservingOrigin: preservingOrigin)
        } else if let width = fixWidth, fixHeight == nil {
            configureLayout { (l) in
                l.width = YGValue(width)
                l.height = YGValueAuto
            }
            let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleHeight)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
        } else if let height = fixHeight, fixWidth == nil {
            
            configureLayout { (l) in
                l.width = YGValueAuto
                l.height = YGValue(height)
            }
            let dimensionFlexibility = YGDimensionFlexibility(arrayLiteral: .flexibleWidth)
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: dimensionFlexibility)
        } else {
            configureLayout { (l) in
                l.width = YGValueAuto
                l.height = YGValueAuto
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

var kissAssociatedKey = "UIView.KissAssociatedKey"
extension UIView {
    public var kiss: Kiss {
        get {
            guard let obj = objc_getAssociatedObject(self, &kissAssociatedKey) as? Kiss else {
                let newKiss = Kiss(view: self)
                objc_setAssociatedObject(self, &kissAssociatedKey, newKiss, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newKiss
            }
            return obj
        }
    }
    
    public class Kiss {
        let _selfView: UIView
        var hasSubLayout = false
        
        weak var currentGroupLayout: GroupLayout? = nil
        init(view: UIView) {
            self._selfView = view
        }
        
        public func constructIfNeed(layout: GroupLayout) {
            guard currentGroupLayout !== layout else { return }
            
            _selfView.resetYoga()
            
            currentGroupLayout?.body.removeFromSuperview()
            currentGroupLayout?.resetViewHierachy()
            currentGroupLayout = layout
            currentGroupLayout?.resetViewHierachy()
            
            if _selfView !== layout.body {
                _selfView.addSubview(layout.body)
            }
            
            layout.constructLayout()
            
            layout.allOverlayGroup.forEach {
                $0.body.removeFromSuperview()
                _selfView.addSubview($0.body)
            }
        }
        
        public var layout: UIViewLayout {
            return _selfView.layout
        }
        
        public func updateChange(width: CGFloat? = nil, height: CGFloat? = nil) {
            currentGroupLayout?.updateLayoutChange(width: width, height: height)
        }
        
        public func estimatedSize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
            return currentGroupLayout?.estimatedSize(width: width, height: height) ?? .zero
        }
        
        // MARK: - VSTACK LAYOUT
        public func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
            let stack = VStackLayout()
            stack.body = _selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }
        
        public func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
            let stack = VStackLayout()
            stack.body = _selfView
            stack.layoutItems.append(builder())
            return stack
        }
        
        // MARK: - HSTACK LAYOUT
        public func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
            let stack = HStackLayout()
            stack.body = _selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }
        
        public func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
            let stack = HStackLayout()
            stack.body = _selfView
            stack.layoutItems.append(builder())
            return stack
        }
        
        // MARK: - WRAP LAYOUT
        public func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
            let stack = WrapLayout()
            stack.body = _selfView
            stack.layoutItems.append(contentsOf: builder())
            return stack
        }
        
        public func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
            let stack = WrapLayout()
            stack.body = _selfView
            stack.layoutItems.append(builder())
            return stack
        }
    }
}
