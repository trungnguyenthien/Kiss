//
//  publicFunction.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public func frame(of layout: ViewLayout) -> CGRect {
    guard let width = layout.expectedWidth,
        let height = layout.expectedHeight,
        let x = layout.expectedX,
        let y = layout.expectedY
    else { return .zero }
    return CGRect(x: x, y: y, width: width, height: height)
}

public func size(of layout: ViewLayout) -> CGSize {
    return frame(of: layout).size
}

