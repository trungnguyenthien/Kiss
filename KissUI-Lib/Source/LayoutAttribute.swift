//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class LayoutAttribute {
    var paddingLeft: Double = 0 // internal(set)
    var paddingRight: Double = 0
    var paddingTop: Double = 0
    var paddingBottom: Double = 0
    
    var leading: Double = 0
    var trailing: Double = 0
    
    var top: Double = 0
    var bottom: Double = 0
    
    var widthValue = WidthValue.fill(1)
    var heightValue = HeightValue.fit
    
    var realWidth: Double = 0
    var realHeight: Double = 0
    
    var verticalAlignment: VerticalAlignmentValue = .top
    var horizontalAlignment: HorizontalAlignmentValue = .left
}


protocol SelfLayoutable {
    func selfLayout(width: Double) -> CGSize
}

protocol Layoutable where Self: LayoutAttribute, Self: SelfLayoutable {
    
}

protocol SetItemLayoutable where Self: Layoutable {
    
}
