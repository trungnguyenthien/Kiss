//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

protocol UIViewLayoutSetter: LayoutItem, MarginSetter, SizeSetter, FlexLayoutItemProtocol, NSCopying {}

public class UIViewLayout: UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var body = makeBlankView()
    var overlayGroups = [GroupLayout]()

    init() {
        attr.maxHeight = .none
        attr.alignSelf = .stretch
    }

    public func crossAlign(self value: CrossAxisAlignment) -> Self {
        attr.alignSelf = value
        return self
    }

    func prepareForRenderingLayout() {}

    func configureLayout() {
        body.configureLayout { yLayout in
            yLayout.isEnabled = true
            yLayout.isIncludedInLayout = self.isVisibleLayout
            yLayout.markDirty()
            self.attr.map(to: yLayout)
        }
    }

    public var isVisibleLayout: Bool {
        body.isVisible
    }

    public var cloned: Self {
        let newInstance = copy()
        if let newInstance = newInstance as? UIViewLayout {
            newInstance.body = body
        }
        return newInstance as! Self // swiftlint:disable:this force_cast
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = UIViewLayout()
        instance.body = body
        instance.attr = attr.copy(with: zone) as! LayoutAttribute // swiftlint:disable:this force_cast
        instance.overlayGroups = overlayGroups
        return instance
    }
}

// MARK: - layout builder function

extension UIViewLayout {
    public func overlay(@GroupLayoutBuilder builder: () -> [GroupLayout]) -> Self {
        let groups = builder()
        groups.forEach { $0.baseView = self.body }
        overlayGroups.append(contentsOf: groups)
        return self
    }

    public func overlay(@GroupLayoutBuilder builder: () -> GroupLayout) -> Self {
        let group = builder()
        group.baseView = body
        overlayGroups.append(group)
        return self
    }
}
