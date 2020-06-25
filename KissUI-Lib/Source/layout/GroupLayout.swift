//
//  GroupLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol GroupLayoutSetter: PaddingSetter, EdgeSetter, SizeSetter, AlignmentSetter {}

public class GroupLayout: LayoutItem, GroupLayoutSetter {
    var layoutItems = [LayoutItem]()
    var attr = LayoutAttribute()
    var overlayGroups = [GroupLayout]()
    
    func overlay(@GroupLayoutBuilder builder: () -> [GroupLayout]) -> Self {
        overlayGroups.append(contentsOf: builder())
        return self
    }
    
    public var isVisible: Bool {
        return hasVisibleView
    }
    
    var arrangeAble: FlexLayoutItemCreator? {
        return self as? FlexLayoutItemCreator
    }
    
    var arrangeAbleItems: [FlexLayoutItemCreator] {
        return layoutItems.compactMap { $0 as? FlexLayoutItemCreator }
    }
    
    func fullOptimize() {
        selfOptimize()
        layoutItems
            .compactMap { $0 as? GroupLayout }
            .forEach { $0.selfOptimize() }
    }
    
    private func selfOptimize() {
        removeInvisibleItem()
        reduceSpacer()
    }
    
    private func removeInvisibleItem() {
        layoutItems.removeAll { !$0.isVisible }
    }
    
    /*
     Loại bỏ trường hợp 2 hay nhiều spacer liên tục nhau thành 1 spacer
     */
    private func reduceSpacer() {
        var secondarySpacer = [Spacer]()
        layoutItems.enumerated().forEach { (index, item) in
            if index == 0 { return }
            let previousItem = layoutItems[index - 1]
            guard let spacer = layoutItems[index] as? Spacer, previousItem is Spacer else { return }
            secondarySpacer.append(spacer)
        }
        
        layoutItems.removeAll { (layoutItem) -> Bool in
            let spacer = layoutItem as? Spacer
            return secondarySpacer.contains { spacer === $0 }
        }
    }
}

extension GroupLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let newInstance = GroupLayout()
        newInstance.layoutItems = self.layoutItems.copy(with: zone)
        newInstance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        newInstance.overlayGroups = self.overlayGroups.copy()
        return newInstance
    }
}

extension GroupLayout {
    var views: [UIView] {
        var output = [UIView?]()
        layoutItems.forEach {
            if let group = $0 as? GroupLayout {
                // Recursive to get all views
                output.append(contentsOf: group.views)
            } else if let viewLayout = $0 as? UIViewLayout {
                output.append(viewLayout.view)
            }
        }
        return output.compactMap { $0 }
    }
    
    var visibleViews: [UIView] {
        return views.filter { $0.isVisible }
    }
    
    var hasVisibleView: Bool {
        return !visibleViews.isEmpty
    }
}
