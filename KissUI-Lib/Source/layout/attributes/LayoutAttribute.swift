//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

typealias KFloat = Double

public class LayoutAttribute: NSObject {
    var isControl = true
    var paddingLeft: KFloat = 0 // internal(set)
    var paddingRight: KFloat = 0
    var paddingTop: KFloat = 0
    var paddingBottom: KFloat = 0
    
    var leading: KFloat = 0
    var trailing: KFloat = 0
    
    var top: KFloat = 0
    var bottom: KFloat = 0
    
    var widthValue = WidthValue.fill(1)
    var heightValue = HeightValue.fit
    
    var minWidth: KFloat? = nil
    var minHeight: KFloat? = nil
    
    var expectedWidth: KFloat? = nil
    var expectedHeight: KFloat? = nil
    var expectedX: KFloat? = nil
    var expectedY: KFloat? = nil
    
    var verticalAlignment: VerticalAlignmentValue = .top
    var horizontalAlignment: HorizontalAlignmentValue = .left
}
