//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit


class LayoutAttribute {
    var userPaddingLeft: Double = 0 // internal(set)
    var userPaddingRight: Double = 0
    var userPaddingTop: Double = 0
    var userPaddingBottom: Double = 0
    
//    var devPaddingLeft: Double = 0 // internal(set)
//    var devPaddingRight: Double = 0
//    var devPaddingTop: Double = 0
//    var devPaddingBottom: Double = 0
    
    var userLeading: Double = 0
    var userTrailing: Double = 0
    var userTop: Double = 0
    var userBottom: Double = 0
    
    var devLeading: Double = 0
    var devTrailing: Double = 0
    var devTop: Double = 0
    var devBottom: Double = 0
    
    var userWidth = DevWidthValue.grow(1)
    var userHeight = DevHeightValue.fit
    var userMaxHeight = DevMaxHeightValue.none
    
    var devWidth: Double? = nil
    var devHeight: Double? = nil
    var devX: Double? = nil
    var devY: Double? = nil
    
    func resetDevValue() {
//        devPaddingLeft = userPaddingLeft
//        devPaddingRight = userPaddingRight
//        devPaddingTop = userPaddingTop
//        devPaddingBottom = userPaddingBottom
        
        devLeading = userLeading
        devTrailing = userTrailing
        devTop = userTop
        devBottom = userBottom
        
        devWidth = nil
        devHeight = nil
        devX = nil
        devY = nil
    }
    
    var userVerticalAlign: AlignVertical = .top
    var userHorizontalAlign: AlignHorizontal = .left
}

extension LayoutAttribute: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = LayoutAttribute()
        
        instance.userPaddingLeft = self.userPaddingLeft
        instance.userPaddingRight = self.userPaddingRight
        instance.userPaddingTop = self.userPaddingTop
        instance.userPaddingBottom = self.userPaddingBottom
        instance.userLeading = self.userLeading
        instance.userTrailing = self.userTrailing
        instance.userTop = self.userTop
        instance.userBottom = self.userBottom
        instance.userWidth = self.userWidth
        instance.userHeight = self.userHeight
        instance.userMaxHeight = self.userMaxHeight
        instance.userVerticalAlign = self.userVerticalAlign
        instance.userHorizontalAlign = self.userHorizontalAlign
        
        instance.resetDevValue()
        return instance
    }  
}
