//
//  internalExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

extension Double {
    static public var max: Double = 99999999999999999.0
    static public var min: Double = -99999999999999999.0
    static public var sameZero: Double = 0.0000000000000000001
}


extension Array {
    func element(_ index: Int) -> Element? {
        if index < 0 || index >= count { return nil }
        return self[index]
    }
    
    var firstIndex: Int {
        return 0
    }
    
    var lastIndex: Int {
        return count - 1
    }
}

func YGValueOrUndefined(_ value: Double?) -> YogaKit.YGValue {
    guard let value = value else { return YGValueUndefined }
    return YogaKit.YGValue(CGFloat(value))
}

func YGValueOrAuto(_ value: Double?) -> YogaKit.YGValue {
    guard let value = value else { return YGValueAuto }
    return YogaKit.YGValue(CGFloat(value))
}
