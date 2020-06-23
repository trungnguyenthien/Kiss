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
    func arrangeItems(forceWidth: Double?, forceHeight: Double?)
}

public func render(group: GroupLayout, forRoot view: UIView) {
    let copy = group.copy() as! GroupLayout
    copy.attr.x = view.x
    copy.attr.y = view.y
    
    var forceWidth: Double? = nil
    var forceHeight: Double? = nil
    
    switch copy.attr.userWidth {
    case .grow(let part) where part == .max: forceWidth = view.width
    case .grow: throwError("Root View không thể set width(.grow)")
    case .value(let width): forceWidth = width
    case .fit: () // forceWidth = nil --> autoFit
    }
    
    switch copy.attr.userHeight {
    case .grow(let part) where part == .max: forceHeight = view.height
    case .grow: throwError("Root View không thể set height(.grow)")
    case .whRatio: throwError("Root View không thể set height(.whRatio)")
    case .fit: () // forceHeight = nil --> autoFit
    case .value(let height): forceHeight = height
    }
    
    group.arrangeAble?.arrangeItems(forceWidth: forceWidth, forceHeight: forceHeight)
}


func addSpacerForAlignment(group: GroupLayout) {
    switch group.attr.userHorizontalAlign {
    case .left: group.layoutItems.insert(spacer, at: 0)
    case .right: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    switch group.attr.userVerticalAlign {
    case .top: group.layoutItems.insert(spacer, at: 0)
    case .bottom: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    group.fullOptimize()
}
