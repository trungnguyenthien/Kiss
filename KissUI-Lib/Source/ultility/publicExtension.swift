//
//  publicExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public extension GroupLayout {
    var views: [UIView] {
        var output = [UIView?]()
        output.append(view)
        subItems.forEach {
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

public extension Sequence where Element: UIView {
    func hideAll() { forEach { $0.isHidden = true } }
    
    func removeFromCurrentSuperview() { forEach { $0.removeFromSuperview() } }
}

public extension UIView {
    func addSubviews(inLayout layout: GroupLayout) {
        layout.views.removeFromCurrentSuperview()
        layout.views.forEach { addSubview($0) }
    }
}
