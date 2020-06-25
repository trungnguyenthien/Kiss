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
        let rootView = UIView()
        attr.width = forceWidth
        attr.height = forceHeight
        
        addSpacerForAlignment(group: self)                  // For horizontal alignment
        removeStartLeadingEndTrailing()
        let hasAlign = forceWidth != nil && forceHeight != nil
        
        removeLeadingTrailingIfHasSpacer(hasAlign: hasAlign)
        makeItemsWidth()                                    // Xác định width(.value), width(.grow), xác định width(.autoFit) cho
        
        return rootView
    }
    
    
    private func removeStartLeadingEndTrailing() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.top = 0
        noSpacerLayoutItems.last?.attr.bottom = 0
    }
    
    private func removeLeadingTrailingIfHasSpacer(hasAlign: Bool) {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.bottom = layoutItems.element(index - 1)?.attr.userBottom ?? 0
            layoutItems.element(index + 1)?.attr.top = layoutItems.element(index + 1)?.attr.userTop ?? 0
            if !hasAlign {
                layoutItems.element(index - 1)?.attr.bottom = 0
                layoutItems.element(index + 1)?.attr.top = 0
            }
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
                
            case .fit where item is GroupLayout:
                guard let group = item as? GroupLayout else { return }
                guard group.attr.width == nil else { return }
                group.arrangeAble?.flexLayoutItem(forceWidth: nil, forceHeight: nil)
                remainWidth -= (item.attr.width ?? 0)
                
            case .fit:
                guard let viewLayout = item as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                viewLayout.attr.width = viewLayout.view?.width ?? 0
                viewLayout.attr.height = viewLayout.view?.height ?? 0
            }
            remainWidth -= item.attr.leading - item.attr.trailing
        }
    }
}
