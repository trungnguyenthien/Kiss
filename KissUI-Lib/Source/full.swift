//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

enum KWidthValue {
    case value(Double)
    case fill(Int)
}

enum KHeightValue {
    case value(Double)
    case fit
    case minMax(Double, Double)
}

struct KLayout {
    var leading = 0.0
    var trailing = 0.0
    
    var top = 0.0
    var bottom = 0.0
    
    var width = KWidthValue.fill(1)
    var height = KHeightValue.fit
}

