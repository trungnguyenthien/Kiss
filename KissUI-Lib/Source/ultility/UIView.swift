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
    func vstack(@ViewBuilder builder: () -> [LayoutItem]) -> VStackLayout {
        let stack = VStackLayout()
        stack.subItems.append(contentsOf: builder())
        return stack
    }

    func vstack(@ViewBuilder builder: () -> LayoutItem) -> VStackLayout {
        let stack = VStackLayout()
        stack.subItems.append(builder())
        return stack
    }

    // MARK: - HSTACK LAYOUT
    func hstack(@ViewBuilder builder: () -> [LayoutItem]) -> HStackLayout {
        let stack = HStackLayout()
        stack.subItems.append(contentsOf: builder())
        return stack
    }

    func hstack(@ViewBuilder builder: () -> LayoutItem) -> HStackLayout {
        let stack = HStackLayout()
        stack.subItems.append(builder())
        return stack
    }

    // MARK: - WRAP LAYOUT
    func wrap(@ViewBuilder builder: () -> [LayoutItem]) -> WrapLayout {
        let stack = WrapLayout()
        stack.subItems.append(contentsOf: builder())
        return stack
    }

    func wrap(@ViewBuilder builder: () -> LayoutItem) -> WrapLayout {
        let stack = WrapLayout()
        stack.subItems.append(builder())
        return stack
    }
    
    // MARK: - VIEWLAYOUT
    var layout: ViewLayout {
        let vlayout = ViewLayout()
        vlayout.view = self
        return vlayout
    }
    
    func render(layout: SetViewLayout) {
        layout.view = self
        layout.attr.expectedX = KFloat(frame.origin.x)
        layout.attr.expectedY = KFloat(frame.origin.y)
        KissUI.render(layout: layout)
    }
}
