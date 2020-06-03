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
    func vstack(_ items: ViewLayout...) -> VStack {
        let stack = VStack()
        stack.view = self
        stack.subLayouts.append(contentsOf: items)
        return stack
    }
    
    func hstack(_ items: ViewLayout...) -> HStack {
        let stack = HStack()
        stack.view = self
        stack.subLayouts.append(contentsOf: items)
        return stack
    }
    
    func wrap(_ items: ViewLayout...) -> Wrap {
        let wrap = Wrap()
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

public func vstack(_ items: ViewLayout...) -> VStack {
    let stack = VStack()
    stack.subLayouts.append(contentsOf: items)
    return stack
}

public func hstack(_ items: ViewLayout...) -> HStack {
    let stack = HStack()
    stack.subLayouts.append(contentsOf: items)
    return stack
}

public func wrap(_ items: ViewLayout...) -> Wrap {
    let wrap = Wrap()
    wrap.subLayouts.append(contentsOf: items)
    return wrap
}

public var vspacer: VSpacer {
    return VSpacer()
}

public var hspacer: HSpacer {
    return HSpacer();
}
