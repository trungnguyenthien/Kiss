//
//  LayoutArrangeAble.swift
//  KissUI
//
//  Created by Trung on 6/9/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol FlexLayoutItemCreator {
    func flexLayoutItem(forceWidth: Double?, forceHeight: Double?) -> UIView
}
