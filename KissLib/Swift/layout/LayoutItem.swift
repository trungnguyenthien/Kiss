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
    var isVisibleLayout: Bool { get }
}

extension Array where Array.Element == LayoutItem {
    func copy(with zone: NSZone? = nil) -> [Array.Element] {
        return map {
            guard let objectCopyAble = $0 as? NSCopying else { return $0 }
            return objectCopyAble.copy(with: zone) as! LayoutItem // swiftlint:disable:this force_cast
        }
    }
}

extension Array where Array.Element == GroupLayout {
    func copy(with zone: NSZone? = nil) -> [Array.Element] {
        return map { $0.copy(with: zone) as! GroupLayout } // swiftlint:disable:this force_cast
    }
}

internal extension LayoutItem {
    private var overlayItems: [GroupLayout] {
        if let item = self as? UIViewLayout {
            return item.overlayGroups
        } else if let group = self as? GroupLayout {
            return group.overlayGroups
        }

        /// Spacer không thể add overlay nên không xét
        return []
    }

    func allOverlayGroups() -> [GroupLayout] {
        var groups = [GroupLayout]()
        groups.append(contentsOf: overlayItems)
        overlayItems.forEach {
            groups.append(contentsOf: $0.overlayItems)
        }
        return groups
    }

    var attr: LayoutAttribute {
        if let item = self as? UIViewLayout {
            return item.attr
        } else if let group = self as? GroupLayout {
            return group.attr
        } else if let spacer = self as? Spacer {
            return spacer.attr
        } else {
            return (self as! LayoutAttribute) // swiftlint:disable:this force_cast
        }
    }

    var root: UIView {
        if let item = self as? UIViewLayout {
            return item.body
        } else if let group = self as? GroupLayout {
            return group.body
        } else if let spacer = self as? Spacer {
            return spacer.body
        } else {
            return UIView()
        }
    }

    var isSpacer: Bool {
        return self is Spacer
    }
}
