//
//  LayoutItem.swift
//  KissUI
//
//  Created by Trung on 6/17/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol LayoutItem { }

internal extension LayoutItem {
    var mutableAttribute: LayoutAttribute {
        if let item = self as? ViewLayout {
            return item.attr
        }
        return (self as! LayoutAttribute)
    }
    
    var view: UIView? {
        guard let viewLayout = self as? ViewLayout else { return nil }
        return viewLayout.view
    }
    
    var subItems: [LayoutItem] {
        guard let viewLayout = self as? SetViewLayout else { return [] }
        return viewLayout.subItems
    }
}


internal extension LayoutItem {
    var paddingLeft: Double {
        get {return mutableAttribute.paddingLeft}
        set {mutableAttribute.paddingLeft = newValue}
    }
    var paddingRight: Double {
        get {return mutableAttribute.paddingRight}
        set {mutableAttribute.paddingRight = newValue}
    }
    var paddingTop: Double {
        get {return mutableAttribute.paddingTop}
        set {mutableAttribute.paddingTop = newValue}
    }
    var paddingBottom: Double {
        get {return mutableAttribute.paddingBottom}
        set {mutableAttribute.paddingBottom = newValue}
    }
    
    var leading: Double {
        get {return mutableAttribute.leading}
        set {mutableAttribute.leading = newValue}
    }
    var trailing: Double {
        get {return mutableAttribute.trailing}
        set {mutableAttribute.trailing = newValue}
    }
    
    var top: Double {
        get {return mutableAttribute.top}
        set {mutableAttribute.top = newValue}
    }
    var bottom: Double {
        get {return mutableAttribute.bottom}
        set {mutableAttribute.bottom = newValue}
    }
    
    var widthDesignValue: DesignWidthValue{
        get {return mutableAttribute.widthDesignValue}
        set {mutableAttribute.widthDesignValue = newValue}
    }
    var heightDesignValue: DesignHeightValue{
        get {return mutableAttribute.heightDesignValue}
        set {mutableAttribute.heightDesignValue = newValue}
    }
    
    var minHeight: Double? {
        get {return mutableAttribute.minHeight}
        set {mutableAttribute.minHeight = newValue}
    }
    
    var expectedWidth: Double? {
        get {return mutableAttribute.expectedWidth}
        set {mutableAttribute.expectedWidth = newValue}
    }
    var expectedHeight: Double? {
        get {return mutableAttribute.expectedHeight}
        set {mutableAttribute.expectedHeight = newValue}
    }
    var expectedX: Double? {
        get {return mutableAttribute.expectedX}
        set {mutableAttribute.expectedX = newValue}
    }
    var expectedY: Double? {
        get {return mutableAttribute.expectedY}
        set {mutableAttribute.expectedY = newValue}
    }
    
    var verticalAlignment: AlignVertical {
        get {return mutableAttribute.verticalAlignment}
        set {mutableAttribute.verticalAlignment = newValue}
    }
    var horizontalAlignment: AlignHorizontal {
        get {return mutableAttribute.horizontalAlignment}
        set {mutableAttribute.horizontalAlignment = newValue}
    }
}
