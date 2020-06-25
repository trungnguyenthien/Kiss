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
        self.attr.userMaxHeight = .none
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

extension HStackLayout: FlexLayoutItemCreator {
    func flexLayoutItem(forceWidth: Double?, forceHeight: Double?) -> UIView {
        attr.width = forceWidth
        attr.height = forceHeight
        addSpacerForAlignment(group: self)                  // For horizontal alignment
        removeStartLeadingEndTrailing()
        removeLeadingTrailingIfHasSpacer()
        
        makeItemsWidth()                                    // Xác định width(.value), width(.grow), xác định width(.autoFit) cho
        
        
        let root = UIView()
        
        root.configureLayout { (l) in
            l.isEnabled = true
            l.justifyContent = .flexStart
            l.direction = .LTR
            l.flexDirection = .row
            l.paddingLeft = YGValue(self.attr.userPaddingLeft)
            l.paddingRight = YGValue(self.attr.userPaddingRight)
            l.paddingTop = YGValue(self.attr.userPaddingTop)
            l.paddingBottom = YGValue(self.attr.userPaddingBottom)
            l.marginLeft = YGValue(self.attr.userLeading)
            l.marginRight = YGValue(self.attr.userTrailing)
            l.marginTop = YGValue(self.attr.userTop)
            l.marginBottom = YGValue(self.attr.userBottom)
            l.maxHeight = YGValue(self.attr.userMaxHeight)
        }
        
        root.applyLayout(layoutItems: layoutItems, fixWidth: forceWidth, fixHeight: forceHeight)
        
        return root
    }
    
    private func makeItemsWidth() {
        var sumPart = 0.0
        var remainWidth = attr.width ?? 0
        remainWidth -= attr.userPaddingLeft
        remainWidth -= attr.userPaddingRight
        
        layoutItems.enumerated().forEach { (index, item) in
            switch item.attr.userWidth {
            case .value(let fix):
                item.attr.width = fix
                remainWidth -= fix
                
            case .grow(let part):
                sumPart += part
                
            case .fit:
                guard let group = item as? GroupLayout else { return }
                guard group.attr.width == nil else { return }
                let myFitWidth = group.arrangeAble?.flexLayoutItem(forceWidth: nil, forceHeight: nil).frame.width
                item.attr.width = Double(myFitWidth ?? 0)
                remainWidth -= (item.attr.width ?? 0)
                
            }
            remainWidth -= item.attr.userLeading - item.attr.userTrailing
        }
        
        layoutItems.forEach {
            switch $0.attr.userWidth {
            case .grow(let part):
                let myWidth = remainWidth * part / sumPart
                $0.attr.width = myWidth
                
            case .value, .fit: ()
            }
        }
    }
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.userLeading = 0
        noSpacerLayoutItems.last?.attr.userTrailing = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.userTrailing = 0
            layoutItems.element(index + 1)?.attr.userLeading = 0
        }
    }
}
