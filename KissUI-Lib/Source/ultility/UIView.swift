//
//  UIView+Extension.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

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
    var layout: ViewLayout {
        let vlayout = ViewLayout()
        vlayout.view = self
        return vlayout
    }
    
    func render(layout: GroupLayout) {
        layout.view = self
        layout.attr.expectedX = Double(frame.origin.x)
        layout.attr.expectedY = Double(frame.origin.y)
        KissUI.render(layout: layout)
    }
}
