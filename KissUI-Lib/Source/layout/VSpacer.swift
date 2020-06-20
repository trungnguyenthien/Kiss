//
//  VSpacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class Spacer: LayoutAttribute, LayoutItem {
    override init() {
        super.init()
        self.widthDesignValue = .grow(.sameZero)
        self.heightDesignValue = .grow(.sameZero)
    }
}

extension Spacer: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return super.copy(with: zone)
    }
}
