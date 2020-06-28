//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit
protocol UIViewLayoutSetter: PaddingSetter, MarginSetter, SizeSetter { }

public class UIViewLayout: LayoutItem, UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var root = makeBlankView()
    
    init() {
        self.attr.userWidth = .fit
        self.attr.userHeight = .fit
    }
    
    public var isVisible: Bool {
        return root.isVisible == true
    }
    
    var labelContent: UILabel? {
        return root as? UILabel
    }
}

extension UIViewLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = UIViewLayout()
        instance.root = self.root
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        return instance
    }
}

extension UIViewLayout: FlexLayoutItemProtocol {
    func layoutRendering() {
        
    }
    
    func configureLayout() {
        root.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
        }
    }
}
