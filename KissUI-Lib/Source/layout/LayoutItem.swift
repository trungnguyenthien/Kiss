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

extension Array where Array.Element == GroupLayout {
    func copy(with zone: NSZone? = nil) -> [Array.Element] {
        return self.map { $0.copy(with: zone) as! GroupLayout }
    }
}

internal extension LayoutItem {
    var attr: LayoutAttribute {
        if let item = self as? UIViewLayout {
            return item.attr
        } else if let group = self as? GroupLayout {
            return group.attr
        } else {
            return (self as! LayoutAttribute)
        }
    }
    
    var layoutItems: [LayoutItem] {
        guard let viewLayout = self as? GroupLayout else { return [] }
        return viewLayout.layoutItems
    }
}

internal extension LayoutItem {
    var userPaddingLeft: Double {
        get {return attr.userPaddingLeft}
        set {attr.userPaddingLeft = newValue}
    }
    
    var userPaddingRight: Double {
        get {return attr.userPaddingRight}
        set {attr.userPaddingRight = newValue}
    }
    
    var userPaddingTop: Double {
        get {return attr.userPaddingTop}
        set {attr.userPaddingTop = newValue}
    }
    
    var userPaddingBottom: Double {
        get {return attr.userPaddingBottom}
        set {attr.userPaddingBottom = newValue}
    }
    
    var userLeading: Double {
        get {return attr.userLeading}
        set {attr.userLeading = newValue}
    }
    
    var userTrailing: Double {
        get {return attr.userTrailing}
        set {attr.userTrailing = newValue}
    }
    
    var userTop: Double {
        get {return attr.userTop}
        set {attr.userTop = newValue}
    }
    
    var userBottom: Double {
        get {return attr.userBottom}
        set {attr.userBottom = newValue}
    }
    
    var userWidth: DevWidthValue{
        get {return attr.userWidth}
        set {attr.userWidth = newValue}
    }
    
    var userHeight: DevHeightValue{
        get {return attr.userHeight}
        set {attr.userHeight = newValue}
    }
    
    var userMaxHeight: DevMaxHeightValue {
        get {return attr.userMaxHeight}
    }
    
    var devWidth: Double? {
        get {return attr.devWidth}
        set {attr.devWidth = newValue}
    }
    
    var devHeight: Double? {
        get {return attr.devHeight}
        set {attr.devHeight = newValue}
    }
    
    var devX: Double? {
        get {return attr.devX}
        set {attr.devX = newValue}
    }
    
    var devY: Double? {
        get {return attr.devY}
        set {attr.devY = newValue}
    }
    
    var userVerticalAlign: AlignVertical {
        get {return attr.userVerticalAlign}
        set {attr.userVerticalAlign = newValue}
    }
    
    var userHorizontalAlign: AlignHorizontal {
        get {return attr.userHorizontalAlign}
        set {attr.userHorizontalAlign = newValue}
    }
}
