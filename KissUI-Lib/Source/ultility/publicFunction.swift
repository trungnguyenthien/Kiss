//
//  publicFunction.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public func frame(of layout: SetViewLayout) -> CGRect {
    return layout.expectedFrame ?? .zero
}

public func size(of layout: SetViewLayout) -> CGSize {
    return frame(of: layout).size
}
