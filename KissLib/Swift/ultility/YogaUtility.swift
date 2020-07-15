//
//  YogaUtility.swift
//  Kiss
//
//  Created by Trung on 7/15/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import YogaKit

func YGValueOrUndefined(_ value: Double?) -> YogaKit.YGValue {
    guard let value = value else { return YGValueUndefined }
    return YogaKit.YGValue(CGFloat(value))
}

func YGValueOrAuto(_ value: Double?) -> YogaKit.YGValue {
    guard let value = value else { return YGValueAuto }
    return YogaKit.YGValue(CGFloat(value))
}
