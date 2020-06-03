//
//  internalExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

extension Sequence where Element: LayoutAttribute {
    func resetExpectedFrame() {
        forEach { $0.expectedFrame = nil }
    }
}

