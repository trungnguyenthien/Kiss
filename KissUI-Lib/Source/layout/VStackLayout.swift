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
    func flexLayoutItem(forceWidth: Double?, forceHeight: Double?) -> UIView {
        attr.width = forceWidth
        attr.height = forceHeight
        
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
        
        root.applyLayout(layoutItems: layoutItems, fixWidth: forceWidth, fixHeight: forceHeight)
        return root
    }
    
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.userTop = 0
        noSpacerLayoutItems.last?.attr.userBottom = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.userTrailing = 0
            layoutItems.element(index + 1)?.attr.userLeading = 0
        }
    }
    
    private func makeItemsWidth() {
        var remainWidth = attr.width ?? 0
        remainWidth -= attr.userPaddingLeft
        remainWidth -= attr.userPaddingRight
        
        layoutItems.enumerated().forEach { (index, item) in
            switch item.attr.userWidth {
            case .value(let fix):
                item.attr.width = fix
                
            case .grow:
                item.attr.width = remainWidth
                
            case .fit:
                guard let group = item as? GroupLayout else { return }
                guard group.attr.width == nil else { return }
                let myFitWidth = group.arrangeAble?.flexLayoutItem(forceWidth: nil, forceHeight: nil).frame.width
                item.attr.width = Double(myFitWidth ?? 0)
                
            }
        }
    }
}
