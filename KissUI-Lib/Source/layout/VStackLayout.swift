//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class VStackLayout: GroupLayout {
    override init() {
        super.init()
        self.attr.userWidth = .grow(.max)
        self.attr.userHeight = .fit
        self.attr.userMaxHeight = .none
        self.attr.alignItems = .stretch
    }
}

extension VStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = VStackLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

extension VStackLayout: FlexLayoutItemProtocol {
    func layoutRendering() {
        resetMargin()
        
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        
        autoMarkDirty()
        autoMarkIncludedInLayout()
        
        layoutItems.forEach {
            guard let flex = $0 as? FlexLayoutItemProtocol else { return }
            flex.layoutRendering()
        }
    }
    
    func configureLayout() {
        root.configureLayout { (l) in
            l.isEnabled = true
            l.direction = .LTR
            l.flexDirection = .column
            
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
            root.addSubview($0.root)
        }
    }
    
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.userMarginTop = 0
        noSpacerLayoutItems.last?.attr.userMarginBottom = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.userMarginRight = 0
            layoutItems.element(index + 1)?.attr.userMarginLeft = 0
        }
    }
}
