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
    var paddingLeft: Double = 0
    var paddingRight: Double = 0
    var paddingTop: Double = 0
    var paddingBottom: Double = 0

    var userMarginLeft: Double = 0
    var userMarginRight: Double = 0
    var userMarginTop: Double = 0
    var userMarginBottom: Double = 0

    var grow: Double?
    var ratio: Double?

    var userWidth: Double?
    var userHeight: Double?
    var maxHeight: Double?
    var minHeight: Double?
    var forcedWidth: Double?
    var forcedHeight: Double?

    var minWidth: Double?
    var maxWidth: Double?

    var forcedLeft: Double = 0
    var forcedRight: Double = 0
    var forcedTop: Double = 0
    var forcedBottom: Double = 0

    var alignStack = MainAxisAlignment.start
    var alignItems = CrossAxisAlignment.start
    var alignSelf: CrossAxisAlignment?
}

extension LayoutAttribute: NSCopying {
    public func copy(with _: NSZone? = nil) -> Any {
        let instance = LayoutAttribute()

        instance.paddingLeft = paddingLeft
        instance.paddingRight = paddingRight
        instance.paddingTop = paddingTop
        instance.paddingBottom = paddingBottom

        instance.userMarginLeft = userMarginLeft
        instance.userMarginRight = userMarginRight
        instance.userMarginTop = userMarginTop
        instance.userMarginBottom = userMarginBottom

        instance.grow = grow
        instance.ratio = ratio

        instance.userWidth = userWidth
        instance.userHeight = userHeight
        instance.maxHeight = maxHeight
        instance.minHeight = minHeight
        instance.maxWidth = maxWidth
        instance.minWidth = minWidth

        instance.forcedLeft = forcedLeft
        instance.forcedRight = forcedRight
        instance.forcedTop = forcedTop
        instance.forcedBottom = forcedBottom

        instance.alignStack = alignStack
        instance.alignItems = alignItems
        instance.alignSelf = alignSelf

        return instance
    }
}

// MARK: - Mapping LayoutAttribute to YGLayout

extension LayoutAttribute {
    func map(to yLayout: YGLayout) {
        yLayout.paddingLeft = YGValueOrUndefined(paddingLeft)
        yLayout.paddingRight = YGValueOrUndefined(paddingRight)
        yLayout.paddingTop = YGValueOrUndefined(paddingTop)
        yLayout.paddingBottom = YGValueOrUndefined(paddingBottom)

        yLayout.marginLeft = YGValueOrUndefined(forcedLeft)
        yLayout.marginRight = YGValueOrUndefined(forcedRight)
        yLayout.marginTop = YGValueOrUndefined(forcedTop)
        yLayout.marginBottom = YGValueOrUndefined(forcedBottom)

        yLayout.maxHeight = YGValueOrUndefined(maxHeight)
        yLayout.minHeight = YGValueOrUndefined(minHeight)

        yLayout.minWidth = YGValueOrUndefined(minWidth)
        yLayout.maxWidth = YGValueOrUndefined(maxWidth)

        switch alignStack {
        case .start: yLayout.justifyContent = .flexStart
        case .end: yLayout.justifyContent = .flexEnd
        case .center: yLayout.justifyContent = .center
        }

        switch alignItems {
        case .start: yLayout.alignItems = .flexStart
        case .end: yLayout.alignItems = .flexEnd
        case .center: yLayout.alignItems = .center
        case .stretch: yLayout.alignItems = .stretch
        }

        switch alignSelf {
        case .some(.center): yLayout.alignSelf = .center
        case .some(.start): yLayout.alignSelf = .flexStart
        case .some(.end): yLayout.alignSelf = .flexEnd
        case .some(.stretch): yLayout.alignSelf = .stretch
        case .none: yLayout.alignSelf = .auto
        }

        if let grow = self.grow {
            setGrow(grow: grow, to: yLayout)
        }
        if let fWidth = forcedWidth {
            yLayout.width = YGValueOrAuto(fWidth)
        } else {
            yLayout.width = YGValueOrAuto(userWidth)
        }

        if let fHeight = forcedHeight {
            yLayout.height = YGValueOrAuto(fHeight)
        } else {
            yLayout.height = YGValueOrAuto(userHeight)
        }

        if let ratio = self.ratio {
            yLayout.aspectRatio = CGFloat(ratio)
        }
    }
}
