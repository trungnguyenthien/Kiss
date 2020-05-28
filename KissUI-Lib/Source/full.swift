//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

enum KWidthValue {
    case value(Double)
    case fill(Int)
}

enum KHeightValue {
    case value(Double)
    case fit
    case minMax(Double, Double)
}

protocol KLayout {
    var paddingLeft: Double { get set }
    var paddingRight: Double { get set }
    var paddingTop: Double { get set }
    var paddingBottom: Double { get set }
    
    var leading: Double { get set }
    var trailing: Double { get set }
    
    var top: Double { get set }
    var bottom: Double { get set }
    
    var width: KWidthValue { get set }
    var height: KHeightValue { get set }
    
    var realWidth: Double { get set }
    
    var views: [UIView] { get set }
}

protocol KAutoLayoutable {
    func layout(width: Double) -> CGSize
}

protocol KLayoutBuildAble {
    func layout() -> KLayout
}
