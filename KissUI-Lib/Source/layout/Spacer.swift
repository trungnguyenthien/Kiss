//
//  VSpacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public class Spacer: LayoutItem {
    public var isVisible: Bool {
        return true
    }
    
    var attr = LayoutAttribute()
    
    init() {
        self.attr.userWidth = .grow(.sameZero)
        self.attr.userHeight = .grow(.sameZero)
    }
}

extension Spacer: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = Spacer()
        instance.attr = self.attr
        return instance
    }
}
