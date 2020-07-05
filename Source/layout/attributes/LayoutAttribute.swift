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
    var paddingLeft: Double = 0 // internal(set)
    var paddingRight: Double = 0
    var paddingTop: Double = 0
    var paddingBottom: Double = 0
    
    var userMarginLeft: Double = 0
    var userMarginRight: Double = 0
    var userMarginTop: Double = 0
    var userMarginBottom: Double = 0
    
    var grow: Double? = nil
    var ratio: Double? = nil
    
    var userWidth: Double? = nil
    var userHeight: Double? = nil
    var maxHeight: Double? = nil
    var minHeight: Double? = nil
    
    var minWidth: Double? = nil
    var maxWidth: Double? = nil
    
    var mLeft: Double = 0
    var mRight: Double = 0
    var mTop: Double = 0
    var mBottom: Double = 0
    
    var alignStack = MainAxisAlignment.start
    var alignItems = CrossAxisAlignment.start
    var alignSelf: CrossAxisAlignment? = nil
    
    func map(to l: YGLayout) {
        l.paddingLeft   = YGValueOrUndefined(self.paddingLeft)
        l.paddingRight  = YGValueOrUndefined(self.paddingRight)
        l.paddingTop    = YGValueOrUndefined(self.paddingTop)
        l.paddingBottom = YGValueOrUndefined(self.paddingBottom)
        
        l.marginLeft    = YGValueOrUndefined(self.mLeft)
        l.marginRight   = YGValueOrUndefined(self.mRight)
        l.marginTop     = YGValueOrUndefined(self.mTop)
        l.marginBottom  = YGValueOrUndefined(self.mBottom)
        
        l.maxHeight     = YGValueOrUndefined(self.maxHeight)
        l.minHeight     = YGValueOrUndefined(self.minHeight)
        
        l.minWidth     = YGValueOrUndefined(self.minWidth)
        l.maxWidth     = YGValueOrUndefined(self.maxWidth)
        
        switch self.alignStack {
        case .start:    l.justifyContent = .flexStart
        case .end:      l.justifyContent = .flexEnd
        case .center:   l.justifyContent = .center
        }
        
        switch self.alignItems {
        case .start:    l.alignItems = .flexStart
        case .end:      l.alignItems = .flexEnd
        case .center:   l.alignItems = .center
        case .stretch:  l.alignItems = .stretch
        }
        
        switch self.alignSelf {
        case .some(.center):   l.alignSelf = .center
        case .some(.start):    l.alignSelf = .flexStart
        case .some(.end):      l.alignSelf = .flexEnd
        case .some(.stretch):  l.alignSelf = .stretch
        case .none:            l.alignSelf = .auto
        }
        
        if let grow = self.grow {
            setGrow(grow: grow, to: l)
        }
        
        if let userHeight = userHeight {
            l.height = YGValueOrUndefined(userHeight)
        } else {
            l.height = YGValueAuto
        }
        
        if let userWidth = userWidth {
            l.width = YGValueOrUndefined(userWidth)
        } else {
            l.width = YGValueAuto
        }
        
        if let ratio = self.ratio {
            l.aspectRatio = CGFloat(ratio)
        }
    }
}

extension LayoutAttribute: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = LayoutAttribute()
        
        instance.paddingLeft = self.paddingLeft
        instance.paddingRight = self.paddingRight
        instance.paddingTop = self.paddingTop
        instance.paddingBottom = self.paddingBottom
        
        instance.userMarginLeft = self.userMarginLeft
        instance.userMarginRight = self.userMarginRight
        instance.userMarginTop = self.userMarginTop
        instance.userMarginBottom = self.userMarginBottom
        
        instance.grow = self.grow
        instance.ratio = self.ratio
        
        instance.userWidth = self.userWidth
        instance.userHeight = self.userHeight
        instance.maxHeight = self.maxHeight
        instance.minHeight = self.minHeight
        instance.maxWidth = self.maxWidth
        instance.minWidth = self.minWidth
        
        instance.mLeft = self.mLeft
        instance.mRight = self.mRight
        instance.mTop = self.mTop
        instance.mBottom = self.mBottom
        
        instance.alignStack = self.alignStack
        instance.alignItems = self.alignItems
        instance.alignSelf = self.alignSelf
        
        return instance
    }  
}
