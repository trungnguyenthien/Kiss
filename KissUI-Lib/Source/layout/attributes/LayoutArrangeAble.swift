//
//  LayoutArrangeAble.swift
//  KissUI
//
//  Created by Trung on 6/9/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol LayoutArrangeAble {
    func arrangeItems()
}

public func render(group: GroupLayout, forRoot view: UIView) {
    let copy = group.copy() as! GroupLayout
    copy.attr.expectedX = view.x
    copy.attr.expectedY = view.y
    
    switch copy.attr.widthDesignValue {
    case .grow(let part) where part == .max: copy.attr.expectedWidth = view.width
    case .grow: throwError("Root View không thể set width(.grow)")
    case .value(let width): copy.attr.expectedWidth = width
    case .autoFit: throwError("Root View không thể set width(.autoFit)")
    }
    
    switch copy.attr.heightDesignValue {
    case .grow(let part) where part == .max: copy.attr.expectedHeight = view.height
    case .grow: throwError("Root View không thể set height(.grow)")
    case .whRatio: throwError("Root View không thể set height(.whRatio)")
    case .autoFit: ()
    case .value(let height): copy.attr.expectedHeight = height
    }
    
    group.arrangeAble?.arrangeItems()
}


func addSpacerForAlignment(group: GroupLayout) {
    switch group.attr.horizontalAlignment {
    case .left: group.layoutItems.insert(spacer, at: 0)
    case .right: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    switch group.attr.verticalAlignment {
    case .top: group.layoutItems.insert(spacer, at: 0)
    case .bottom: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    group.fullOptimize()
}

func updateForMinHeight(item: LayoutAttribute) {
    guard let currentHeight = item.expectedHeight,
        let minHeight = item.minHeight else { return }
    item.expectedHeight = max(currentHeight, minHeight)
}
