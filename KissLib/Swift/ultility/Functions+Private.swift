//
//  Functions+Private.swift
//
//  Created by Trung on 7/15/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

func setGrow(grow: Double, to layout: YGLayout) {
    let cgGrow = CGFloat(grow)
    layout.flexGrow = cgGrow
    layout.flexShrink = cgGrow
    layout.flex = cgGrow
}

func makeBlankView() -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    view.isUserInteractionEnabled = false
    return view
}
