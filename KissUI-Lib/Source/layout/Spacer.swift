//
//  Spacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class Spacer: LayoutItem, FlexLayoutItemCreator {
    var attr = LayoutAttribute()
    var root = makeBlankView()
    
    func configureLayout() {
        root.configureLayout { (l) in
            l.isEnabled = true
            self.attr.mapPaddingMarginMaxHeight(to: l)
            setGrow(grow: -0.000000000001, to: l)
        }
    }
    
    public var isVisible: Bool {
        return true
    }
}

extension Spacer: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = Spacer()
        instance.attr = self.attr
        return instance
    }
}


