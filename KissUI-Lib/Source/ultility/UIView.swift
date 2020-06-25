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
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
        let stack = VStackLayout()
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - HSTACK LAYOUT
    func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
        let stack = HStackLayout()
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
        let stack = HStackLayout()
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - WRAP LAYOUT
    func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
        let stack = WrapLayout()
        stack.layoutItems.append(contentsOf: builder())
        return stack
    }
    
    func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
        let stack = WrapLayout()
        stack.layoutItems.append(builder())
        return stack
    }
    
    // MARK: - VIEWLAYOUT
    var layout: UIViewLayout {
        let vlayout = UIViewLayout()
        vlayout.view = self
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
    
    func applyLayout(layoutItems: [LayoutItem], fixWidth: Double?, fixHeight: Double?) {
        layoutItems.forEach { (layoutItem) in
            guard let flexItem = layoutItem as? FlexLayoutItemCreator else { return }
            self.addSubview(flexItem.flexLayoutItem(forceWidth: layoutItem.attr.width, forceHeight: layoutItem.attr.height))
        }
        
        self.applyLayout(preservingOrigin: false, fixWidth: fixWidth, fixHeight: fixHeight)
    }
    
    func applyLayout(preservingOrigin: Bool, fixWidth: Double?, fixHeight: Double?) {
        if let width = fixWidth, let height = fixHeight {
            yoga.width = YGValue(CGFloat(width))
            yoga.height = YGValue(CGFloat(height))
            yoga.applyLayout(preservingOrigin: preservingOrigin)
        } else if let width = fixWidth, fixHeight == nil {
            yoga.width = YGValue(CGFloat(width))
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleHeight))
        } else if let height = fixHeight, fixWidth == nil {
            yoga.height = YGValue(CGFloat(height))
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleWidth))
        } else {
            yoga.width = YGValueUndefined
            yoga.height = YGValueUndefined
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: YGDimensionFlexibility(arrayLiteral: .flexibleWidth, .flexibleHeight))
        }
    }
}
