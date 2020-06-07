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

    // MARK: - ZSTACK LAYOUT
    func zstack(@ViewBuilder builder: () -> [LayoutAttribute]) -> ZStackLayout {
        let stack = ZStackLayout()
        stack.subLayouts.append(contentsOf: builder())
        return stack
    }

    func zstack(@ViewBuilder builder: () -> LayoutAttribute) -> ZStackLayout {
        let stack = ZStackLayout()
        stack.subLayouts.append(builder())
        return stack
    }
    
    // MARK: - VIEWLAYOUT
    var layout: ViewLayout {
        let vlayout = ViewLayout()
        vlayout.view = self
        return vlayout
    }
}
