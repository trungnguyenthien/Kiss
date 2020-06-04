//
//  publicExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public extension SetViewLayout {
    var views: [UIView] {
        var output = [UIView?]()
        output.append(view)
        subLayouts.forEach {
            if let setViewLayout = $0 as? SetViewLayout {
                // Recursive to get all views
                output.append(contentsOf: setViewLayout.views)
            } else if let viewLayout = $0 as? ViewLayout {
                output.append(viewLayout.view)
            }
        }
        return output.compactMap { $0 }
    }
}

public extension Sequence where Element: UIView {
    func hideAll() {
        forEach { $0.isHidden = true }
    }
    
    func removeFromCurrentSuperview() {
        forEach {
            $0.removeFromSuperview()
        }
    }
}

public extension UIView {
    func addSubviews(inLayout layout: SetViewLayout) {
        layout.views.removeFromCurrentSuperview()
        layout.views.forEach { addSubview($0) }
    }
}
