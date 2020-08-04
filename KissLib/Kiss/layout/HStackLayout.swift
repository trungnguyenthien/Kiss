//
//  HStackLayout.swift
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

public class HStackLayout: GroupLayout {
    override init() {
        super.init()
        attr.maxHeight = .none
        attr.alignItems = .stretch
    }

    public override func copy(with zone: NSZone? = nil) -> Any {
        let newInstance = HStackLayout()
        newInstance.layoutItems = layoutItems.copy(with: zone)
        newInstance.baseView = baseView
        newInstance.autoInvisibility = autoInvisibility
        newInstance.overlayGroups = overlayGroups
        return newInstance
    }

    override func prepareForRenderingLayout() {
        resetForcedValue()

        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        layoutItems
            .compactMap { $0 as? FlexLayoutItemProtocol }
            .forEach { flex in
                flex.prepareForRenderingLayout()
            }
    }

    override func configureLayout() {
        body.configureLayout { yLayout in
            yLayout.isEnabled = true
            yLayout.direction = .LTR
            yLayout.flexDirection = .row
            yLayout.flexWrap = .noWrap
            yLayout.isIncludedInLayout = self.isVisibleLayout

            self.attr.map(to: yLayout)
        }

        layoutItems.forEach {
            guard let flex = $0 as? FlexLayoutItemProtocol else { return }
            flex.configureLayout()
            $0.root.removeFromSuperview()
            body.addSubview($0.root)
        }
    }

    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { $0.isVisibleLayout }
        noSpacerLayoutItems.first?.attr.forcedLeft = 0
        noSpacerLayoutItems.last?.attr.forcedRight = 0
    }

    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { index, item in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.forcedRight = 0
            layoutItems.element(index + 1)?.attr.forcedLeft = 0
        }
    }
}
