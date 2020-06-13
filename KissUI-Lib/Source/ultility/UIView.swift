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
    func vstack(@ViewBuilder builder: () -> [LayoutAttribute]) -> VStackLayout {
        let stack = VStackLayout()
        stack.subLayouts.append(contentsOf: builder())
        return stack
    }

    func vstack(@ViewBuilder builder: () -> LayoutAttribute) -> VStackLayout {
        let stack = VStackLayout()
        stack.subLayouts.append(builder())
        return stack
    }

    // MARK: - HSTACK LAYOUT
    func hstack(@ViewBuilder builder: () -> [LayoutAttribute]) -> HStackLayout {
        let stack = HStackLayout()
        stack.subLayouts.append(contentsOf: builder())
        return stack
    }

    func hstack(@ViewBuilder builder: () -> LayoutAttribute) -> HStackLayout {
        let stack = HStackLayout()
        stack.subLayouts.append(builder())
        return stack
    }

    // MARK: - WRAP LAYOUT
    func wrap(@ViewBuilder builder: () -> [LayoutAttribute]) -> WrapLayout {
        let stack = WrapLayout()
        stack.subLayouts.append(contentsOf: builder())
        return stack
    }

    func wrap(@ViewBuilder builder: () -> LayoutAttribute) -> WrapLayout {
        let stack = WrapLayout()
        stack.subLayouts.append(builder())
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
        layout.expectedX = KFloat(frame.origin.x)
        layout.expectedY = KFloat(frame.origin.y)
        KissUI.render(layout: layout)
    }
}
