//
//  internalExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
}

extension Double {
    static public var max: Double = 99999999999999999.0
    static public var min: Double = -99999999999999999.0
    static public var sameZero: Double = 0.0000000000000000001
}

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var notNil: Bool {
        return self != nil
    }
}
