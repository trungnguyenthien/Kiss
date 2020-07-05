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
        let newInstance = WrapLayout()
        newInstance.layoutItems = self.layoutItems.copy(with: zone)
        newInstance.baseView = self.baseView
        newInstance.autoInvisibility = self.autoInvisibility
        newInstance.lineSpacing = self.lineSpacing
        return newInstance
    }
    
    override func prepareForRenderingLayout() {
        resetMargin()
        removeLeadingTrailingIfHasSpacer()
        
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
            l.flexWrap = .wrap
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
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.mRight = 0
            layoutItems.element(index + 1)?.attr.mLeft = 0
        }
    }
}
