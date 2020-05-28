//
//  UIView+Extension.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

struct KItemLayout: KLayout {
    var paddingLeft: Double = 0
    
    var paddingRight: Double = 0
    
    var paddingTop: Double = 0
    
    var paddingBottom: Double = 0
    
    var leading: Double = 0
    
    var trailing: Double = 0
    
    var top: Double = 0
    
    var bottom: Double = 0
    
    var width = KWidthValue.fill(1)
    
    var height = KHeightValue.fit
    
    var realWidth: Double = 0
    
    var views: [UIView] = []
}

extension UIView {
    
}
