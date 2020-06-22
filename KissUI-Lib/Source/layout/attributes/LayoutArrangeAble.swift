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
    func arrangeItems(draft: Bool)
}

public func render(group: GroupLayout, forRoot view: UIView) {
    let copy = group.copy() as! GroupLayout
    copy.attr.devX = view.x
    copy.attr.devY = view.y
    
    switch copy.attr.userWidth {
    case .grow(let part) where part == .max: copy.attr.devWidth = view.width
    case .grow: throwError("Root View không thể set width(.grow)")
    case .value(let width): copy.attr.devWidth = width
    case .fit: throwError("Root View không thể set width(.autoFit)")
    }
    
    switch copy.attr.userHeight {
    case .grow(let part) where part == .max: copy.attr.devHeight = view.height
    case .grow: throwError("Root View không thể set height(.grow)")
    case .whRatio: throwError("Root View không thể set height(.whRatio)")
    case .fit: ()
    case .value(let height): copy.attr.devHeight = height
    }
    
    group.arrangeAble?.arrangeItems(draft: false)
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
