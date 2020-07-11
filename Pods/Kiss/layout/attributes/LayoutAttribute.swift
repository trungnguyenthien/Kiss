//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import yoga

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
    var forcedWidth: Double? = nil
    var forcedHeight: Double? = nil
    
    var minWidth: Double? = nil
    var maxWidth: Double? = nil
    
    var forcedLeft: Double = 0
    var forcedRight: Double = 0
    var forcedTop: Double = 0
    var forcedBottom: Double = 0
    
    var alignStack = MainAxisAlignment.start
    var alignItems = CrossAxisAlignment.start
    var alignSelf: CrossAxisAlignment? = nil
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
        
        instance.forcedLeft = self.forcedLeft
        instance.forcedRight = self.forcedRight
        instance.forcedTop = self.forcedTop
        instance.forcedBottom = self.forcedBottom
        
        instance.alignStack = self.alignStack
        instance.alignItems = self.alignItems
        instance.alignSelf = self.alignSelf
        
        return instance
    }  
}

// MARK:- Mapping LayoutAttribute to YGLayout
extension LayoutAttribute {
    func map(to l: YGLayout) {
        l.paddingLeft   = YGValueOrUndefined(self.paddingLeft)
        l.paddingRight  = YGValueOrUndefined(self.paddingRight)
        l.paddingTop    = YGValueOrUndefined(self.paddingTop)
        l.paddingBottom = YGValueOrUndefined(self.paddingBottom)
        
        l.marginLeft    = YGValueOrUndefined(self.forcedLeft)
        l.marginRight   = YGValueOrUndefined(self.forcedRight)
        l.marginTop     = YGValueOrUndefined(self.forcedTop)
        l.marginBottom  = YGValueOrUndefined(self.forcedBottom)
        
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
        if let fWidth = forcedWidth {
            l.width = YGValueOrAuto(fWidth)
        } else {
            l.width = YGValueOrAuto(userWidth)
        }
        
        if let fHeight = forcedHeight {
            l.height = YGValueOrAuto(fHeight)
        } else {
            l.height = YGValueOrAuto(userHeight)
        }
        
        if let ratio = self.ratio {
            l.aspectRatio = CGFloat(ratio)
        }
    }
}
