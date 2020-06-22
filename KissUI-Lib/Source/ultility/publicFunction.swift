//
//  publicFunction.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public func frame(of layout: UIViewLayout) -> CGRect {
    guard let width = layout.attr.width,
        let height = layout.attr.height,
        let x = layout.attr.x,
        let y = layout.attr.y
    else { return .zero }
    return CGRect(x: x, y: y, width: width, height: height)
}

public func size(of layout: UIViewLayout) -> CGSize {
    return frame(of: layout).size
}

