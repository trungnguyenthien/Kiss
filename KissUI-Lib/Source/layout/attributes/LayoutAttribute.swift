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
    
    var userMarginLeft: Double = 0
    var userMarginRight: Double = 0
    var userMarginTop: Double = 0
    var userMarginBottom: Double = 0
    
    var userWidth = DevWidthValue.grow(1)
    var userHeight = DevHeightValue.fit
    var userMaxHeight: Double? = nil
    
    var mLeft: Double = 0
    var mRight: Double = 0
    var mTop: Double = 0
    var mBottom: Double = 0
    
    //    var width: Double? = nil
    //    var height: Double? = nil
    //    var x: Double? = nil
    //    var y: Double? = nil
    
    var alignStack = StackAlignment.start
    var alignItems = ItemAlignment.start
    var alignSelf = ItemAlignment.start
    
    func map(to l: YGLayout) {
        l.paddingLeft   = YGValue(self.userPaddingLeft)
        l.paddingRight  = YGValue(self.userPaddingRight)
        l.paddingTop    = YGValue(self.userPaddingTop)
        l.paddingBottom = YGValue(self.userPaddingBottom)
        
        l.marginLeft    = YGValue(self.mLeft)
        l.marginRight   = YGValue(self.mRight)
        l.marginTop     = YGValue(self.mTop)
        l.marginBottom  = YGValue(self.mBottom)
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
        
        switch self.alignSelf {
        case .center:   l.alignSelf = .center
        case .start:    l.alignSelf = .flexStart
        case .end:      l.alignSelf = .flexEnd
        case .stretch:  l.alignSelf = .stretch
        }
        
        switch self.alignStack {
        case .start: l.justifyContent = .flexStart
        case .end: l.justifyContent = .flexEnd
        case .center: l.justifyContent = .center
        }
        
        switch self.alignItems {
        case .start: l.alignItems = .flexStart
        case .end: l.alignItems = .flexEnd
        case .center: l.alignItems = .center
        case .stretch: l.alignItems = .stretch
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
        instance.userMarginLeft = self.userMarginLeft
        instance.userMarginRight = self.userMarginRight
        instance.userMarginTop = self.userMarginTop
        instance.userMarginBottom = self.userMarginBottom
        instance.userWidth = self.userWidth
        instance.userHeight = self.userHeight
        instance.userMaxHeight = self.userMaxHeight
        instance.alignStack = self.alignStack
        instance.alignItems = self.alignItems
        instance.alignSelf = self.alignSelf
        return instance
    }  
}
