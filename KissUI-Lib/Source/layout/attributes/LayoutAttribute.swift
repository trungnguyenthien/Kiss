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
    
    var widthDesignValue = DesignWidthValue.grow(1)
    var heightDesignValue = DesignHeightValue.autoFit
    
    var minHeight: Double? = nil
    
    var expectedWidth: Double? = nil
    var expectedHeight: Double? = nil
    var expectedX: Double? = nil
    var expectedY: Double? = nil
    
    var verticalAlignment: AlignVertical = .top
    var horizontalAlignment: AlignHorizontal = .left
}

extension LayoutAttribute {
    public func copy(with zone: NSZone? = nil) -> LayoutAttribute {
        let copy = LayoutAttribute()
        copy.paddingLeft = self.paddingLeft
        copy.paddingRight = self.paddingRight
        copy.paddingTop = self.paddingTop
        copy.paddingBottom = self.paddingBottom
        copy.leading = self.leading
        copy.trailing = self.trailing
        copy.top = self.top
        copy.bottom = self.bottom
        copy.widthDesignValue = self.widthDesignValue
        copy.heightDesignValue = self.heightDesignValue
        copy.minHeight = self.minHeight
        copy.expectedWidth = self.expectedWidth
        copy.expectedHeight = self.expectedHeight
        copy.expectedX = self.expectedX
        copy.expectedY = self.expectedY
        copy.verticalAlignment = self.verticalAlignment
        copy.horizontalAlignment = self.horizontalAlignment
        return copy
    }  
}
