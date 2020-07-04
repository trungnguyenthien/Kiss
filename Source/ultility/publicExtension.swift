//
//  publicExtension.swift
//  KissUI
//
//  Created by Trung on 6/3/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

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

public extension Sequence where Element == Optional<Any> {
    var compacts: [Element] {
        compactMap { $0 }
    }
}

public extension Sequence {
    func max<T: Comparable>(`where`: (Element?) -> T) -> T? {
        let ts = compactMap { $0 }.compactMap { `where`($0) }
        return ts.sorted { $0 < $1 }.last
    }
    
    func min<T: Comparable>(`where`: (Element?) -> T) -> T? {
        let ts = compactMap { $0 }.compactMap { `where`($0) }
        return ts.sorted { $0 < $1 }.first
    }
}
