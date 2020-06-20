//
//  GroupLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class GroupLayout: ViewLayout, AlignmentSetter {
    var layoutItems = [LayoutItem]()
    
    public override var isVisible: Bool {
        return hasVisibleView
    }
    
    func optimize() {
        removeInvisibleItem()
        reduceSpacer()
    }
    
    private func removeInvisibleItem() {
        layoutItems.removeAll { !$0.isVisible }
    }
    
    private func reduceSpacer() {
        var secondarySpacer = [Spacer]()
        layoutItems.enumerated().forEach { (index, item) in
            if index == 0 { return }
            let previousItem = layoutItems[index - 1]
            guard let spacer = layoutItems[index] as? Spacer, previousItem is Spacer else { return }
            secondarySpacer.append(spacer)
        }
        layoutItems.removeAll { (layoutItem) -> Bool in
            guard let spacer = layoutItem as? Spacer else { return false }
            return secondarySpacer.contains { (second) -> Bool in
                return spacer == second
            }
        }
    }
}

extension GroupLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let newInstance = GroupLayout()
        newInstance.view = self.view
        newInstance.layoutItems = self.layoutItems.copy(with: zone)
        newInstance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        return newInstance
    }
}

extension GroupLayout {
    var views: [UIView] {
        var output = [UIView?]()
        output.append(view)
        layoutItems.forEach {
            if let group = $0 as? GroupLayout {
                // Recursive to get all views
                output.append(contentsOf: group.views)
            } else if let viewLayout = $0 as? ViewLayout {
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
