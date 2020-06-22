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
    
    var userLeading: Double = 0
    var userTrailing: Double = 0
    var userTop: Double = 0
    var userBottom: Double = 0
    
    var leading: Double = 0
    var trailing: Double = 0
    var top: Double = 0
    var bottom: Double = 0
    
    var userWidth = DevWidthValue.grow(1)
    var userHeight = DevHeightValue.fit
    var userMaxHeight = DevMaxHeightValue.none
    
    var width: Double? = nil
    var height: Double? = nil
    var x: Double? = nil
    var y: Double? = nil
    
    func resetDevEdgeValue() {
        leading = userLeading
        trailing = userTrailing
        top = userTop
        bottom = userBottom
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
        
        instance.resetDevEdgeValue()
        return instance
    }  
}
