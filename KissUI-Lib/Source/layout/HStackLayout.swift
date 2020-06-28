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
        self.attr.userWidth = .grow(.max)
        self.attr.userHeight = .fit
        self.attr.maxHeight = .none
    }
}

extension HStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = HStackLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

extension HStackLayout: FlexLayoutItemProtocol {
    func layoutRendering() {
        resetMargin()
        
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        
        autoMarkDirty()
        autoMarkIncludedInLayout()
        
        layoutItems.forEach { (layoutItem) in
            layoutItem.root.configureLayout { (l) in
                l.isEnabled = true
                layoutItem.attr.map(to: l)
            }
            guard let flex = layoutItem as? FlexLayoutItemProtocol else { return }
            flex.layoutRendering()
        }
    }
    
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            l.direction = .LTR
            l.flexDirection = .row
            
            self.attr.map(to: l)
        }
        
        layoutItems.forEach { (layoutItem) in
            guard layoutItem.attr.alignSelf == .none else { return }
            layoutItem.attr.alignSelf = self.attr.alignItems
        }
        
        layoutItems.forEach {
            guard let flex = $0 as? FlexLayoutItemProtocol else { return }
            flex.configureLayout()
            $0.root.removeFromSuperview()
            body.addSubview($0.root)
        }
    }
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { $0.isVisible }
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
