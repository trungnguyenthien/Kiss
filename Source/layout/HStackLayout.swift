//
//  HStackLayout.swift
//  KissUI
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
        self.attr.maxHeight = .none
        self.attr.alignItems = .stretch
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let newInstance = HStackLayout()
        newInstance.layoutItems = self.layoutItems.copy(with: zone)
        newInstance.baseView = self.baseView
        newInstance.autoInvisibility = self.autoInvisibility
        newInstance.overlayGroups = self.overlayGroups
        return newInstance
    }
    
    override func prepareForRenderingLayout() {
        resetMargin()
        
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        
//        autoMarkDirty()
        
        layoutItems
            .compactMap { $0 as? FlexLayoutItemProtocol }
            .forEach { (flex) in
            flex.prepareForRenderingLayout()
        }
    }
    
    override func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            l.direction = .LTR
            l.flexDirection = .row
            l.flexWrap = .noWrap
            l.isIncludedInLayout = self.isVisibleLayout
            
            self.attr.map(to: l)
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
        noSpacerLayoutItems.first?.attr.mLeft = 0
        noSpacerLayoutItems.last?.attr.mRight = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.mRight = 0
            layoutItems.element(index + 1)?.attr.mLeft = 0
        }
    }
}
