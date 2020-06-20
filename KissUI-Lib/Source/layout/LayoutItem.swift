//
//  LayoutItem.swift
//  KissUI
//
//  Created by Trung on 6/17/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol LayoutItem {
    var isVisible: Bool { get }
}

extension Array where Array.Element == LayoutItem {
    func copy(with zone: NSZone? = nil) -> [Array.Element] {
        return self.map {
            guard let objectCopyAble = $0 as? NSCopying else { return $0 }
            return objectCopyAble.copy(with: zone) as! LayoutItem
        }
    }
}

internal extension LayoutItem {
    var attr: LayoutAttribute {
        if let item = self as? UIViewLayout {
            return item.attr
        }
        return (self as! LayoutAttribute)
    }
    
    var view: UIView? {
        guard let viewLayout = self as? UIViewLayout else { return nil }
        return viewLayout.view
    }
    
    var layoutItems: [LayoutItem] {
        guard let viewLayout = self as? GroupLayout else { return [] }
        return viewLayout.layoutItems
    }
}

internal extension LayoutItem {
    var paddingLeft: Double {
        get {return attr.paddingLeft}
        set {attr.paddingLeft = newValue}
    }
    
    var paddingRight: Double {
        get {return attr.paddingRight}
        set {attr.paddingRight = newValue}
    }
    
    var paddingTop: Double {
        get {return attr.paddingTop}
        set {attr.paddingTop = newValue}
    }
    
    var paddingBottom: Double {
        get {return attr.paddingBottom}
        set {attr.paddingBottom = newValue}
    }
    
    var leading: Double {
        get {return attr.leading}
        set {attr.leading = newValue}
    }
    
    var trailing: Double {
        get {return attr.trailing}
        set {attr.trailing = newValue}
    }
    
    var top: Double {
        get {return attr.top}
        set {attr.top = newValue}
    }
    
    var bottom: Double {
        get {return attr.bottom}
        set {attr.bottom = newValue}
    }
    
    var widthDesignValue: DesignWidthValue{
        get {return attr.widthDesignValue}
        set {attr.widthDesignValue = newValue}
    }
    
    var heightDesignValue: DesignHeightValue{
        get {return attr.heightDesignValue}
        set {attr.heightDesignValue = newValue}
    }
    
    var minHeight: Double? {
        get {return attr.minHeight}
        set {attr.minHeight = newValue}
    }
    
    var expectedWidth: Double? {
        get {return attr.expectedWidth}
        set {attr.expectedWidth = newValue}
    }
    
    var expectedHeight: Double? {
        get {return attr.expectedHeight}
        set {attr.expectedHeight = newValue}
    }
    
    var expectedX: Double? {
        get {return attr.expectedX}
        set {attr.expectedX = newValue}
    }
    
    var expectedY: Double? {
        get {return attr.expectedY}
        set {attr.expectedY = newValue}
    }
    
    var verticalAlignment: AlignVertical {
        get {return attr.verticalAlignment}
        set {attr.verticalAlignment = newValue}
    }
    
    var horizontalAlignment: AlignHorizontal {
        get {return attr.horizontalAlignment}
        set {attr.horizontalAlignment = newValue}
    }
}
