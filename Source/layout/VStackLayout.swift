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
        self.attr.maxHeight = .none
        self.attr.alignItems = .stretch
    }
    
    override func layoutRendering() {
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
    
    override func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            l.direction = .LTR
            l.flexDirection = .column
            l.flexWrap = .noWrap
            
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
