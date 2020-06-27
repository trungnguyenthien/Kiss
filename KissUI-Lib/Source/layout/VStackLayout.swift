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

extension VStackLayout: FlexLayoutItemCreator {
    func configureLayout() {
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        
        root.configureLayout { (l) in
            l.isEnabled = true
            l.direction = .LTR
            l.flexDirection = .column
            
            self.attr.mapPaddingMarginMaxHeight(to: l)
            
            
            switch self.attr.userHorizontalAlign {
            case .left:   l.justifyContent = .flexStart
            case .right:  l.justifyContent = .flexEnd
            case .center: l.justifyContent = .center
            }
            
            switch self.attr.userVerticalAlign {
            case .top:    l.alignItems = .flexStart
            case .bottom: l.alignItems = .flexEnd
            case .center: l.alignItems = .center
            }
        }
        
        let defaultSelfAlign: SelfAlign = {
            switch self.attr.userVerticalAlign {
            case .bottom: return .end
            case .top:    return .start
            case .center: return .center
            }
        }()
        
        layoutItems.forEach { (layoutItem) in
            guard layoutItem.attr.userSelfAlign == .none else { return }
            layoutItem.attr.userSelfAlign = defaultSelfAlign
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
