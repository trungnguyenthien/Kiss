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
        let instance = LayoutAttribute()
        instance.paddingLeft = self.paddingLeft
        instance.paddingRight = self.paddingRight
        instance.paddingTop = self.paddingTop
        instance.paddingBottom = self.paddingBottom
        instance.leading = self.leading
        instance.trailing = self.trailing
        instance.top = self.top
        instance.bottom = self.bottom
        instance.widthDesignValue = self.widthDesignValue
        instance.heightDesignValue = self.heightDesignValue
        instance.minHeight = self.minHeight
        instance.expectedWidth = self.expectedWidth
        instance.expectedHeight = self.expectedHeight
        instance.expectedX = self.expectedX
        instance.expectedY = self.expectedY
        instance.verticalAlignment = self.verticalAlignment
        instance.horizontalAlignment = self.horizontalAlignment
        return instance
    }  
}
