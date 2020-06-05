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
    func vstack(_ items: LayoutAttribute...) -> VStackLayout {
        let stack = VStackLayout()
        stack.view = self
        stack.subLayouts.append(contentsOf: items)
        return stack
    }
    
    func hstack(_ items: LayoutAttribute...) -> HStackLayout {
        let stack = HStackLayout()
        stack.view = self
        stack.subLayouts.append(contentsOf: items)
        return stack
    }
    
    func zStack(_ items: LayoutAttribute...) -> ZStackLayout {
        let wrap = ZStackLayout()
        wrap.view = self
        wrap.subLayouts.append(contentsOf: items)
        return wrap
    }
    
    var layout: ViewLayout {
        let vlayout = ViewLayout()
        vlayout.view = self
        return vlayout
    }
}
