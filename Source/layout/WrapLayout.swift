//
//  WrapLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class WrapLayout: GroupLayout {
    var lineSpacing = 0.0

    override init() {
        super.init()
        self.attr.maxHeight = .none
    }
    
    public func line(spacing: Double) -> Self {
        lineSpacing = spacing
        return self
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        guard let instance = super.copy() as? WrapLayout else { return self }
        instance.lineSpacing = self.lineSpacing
        return instance
    }
    
    override func layoutRendering() {
         resetMargin()
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
             l.flexDirection = .row
             l.flexWrap = .wrap
             
             self.attr.map(to: l)
         }
         
         layoutItems.forEach {
             guard let flex = $0 as? FlexLayoutItemProtocol else { return }
             flex.configureLayout()
             $0.root.removeFromSuperview()
             body.addSubview($0.root)
         }
     }
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.mRight = 0
            layoutItems.element(index + 1)?.attr.mLeft = 0
        }
    }
}
