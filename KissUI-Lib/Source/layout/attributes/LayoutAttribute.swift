//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

class LayoutAttribute {
    var userPaddingLeft: Double = 0 // internal(set)
    var userPaddingRight: Double = 0
    var userPaddingTop: Double = 0
    var userPaddingBottom: Double = 0
    var userSelfAlign = SelfAlign.none
    
    var userLeading: Double = 0
    var userTrailing: Double = 0
    var userTop: Double = 0
    var userBottom: Double = 0
    
    var userWidth = DevWidthValue.grow(1)
    var userHeight = DevHeightValue.fit
    var userMaxHeight: Double? = nil
    
    var width: Double? = nil
    var height: Double? = nil
    var x: Double? = nil
    var y: Double? = nil
    
    var userVerticalAlign: AlignVertical = .top
    var userHorizontalAlign: AlignHorizontal = .left
    
    var stackAlignment: Alignment = .start
    var defaultItemAlignment: Alignment = .start
    
    func mapPaddingMarginMaxHeight(to l: YGLayout) {
        l.paddingLeft   = YGValue(self.userPaddingLeft)
        l.paddingRight  = YGValue(self.userPaddingRight)
        l.paddingTop    = YGValue(self.userPaddingTop)
        l.paddingBottom = YGValue(self.userPaddingBottom)
        l.marginLeft    = YGValue(self.userLeading)
        l.marginRight   = YGValue(self.userTrailing)
        l.marginTop     = YGValue(self.userTop)
        l.marginBottom  = YGValue(self.userBottom)
        l.maxHeight     = YGValue(self.userMaxHeight)
        
        switch self.userHeight {
        case .fit:                    l.alignSelf = .flexStart
        case .value(let height):      l.height = YGValue(height)
        case .aspectRatio(let ratio): l.aspectRatio = CGFloat(ratio)
        case .grow(let grow):         setGrow(grow: grow, to: l)
        }
        
        switch self.userWidth {
        case .value(let width): l.width = YGValue(width)
        case .grow(let grow):   setGrow(grow: grow, to: l)
        case .fit:              l.alignSelf = .flexStart
        }
        
        switch self.userSelfAlign {
        case .center:   l.alignSelf = .center
        case .start:    l.alignSelf = .flexStart
        case .end:      l.alignSelf = .flexEnd
        case .stretch:  l.alignSelf = .stretch
        case .none:     l.alignSelf = .stretch
        }
    }
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
        return instance
    }  
}
