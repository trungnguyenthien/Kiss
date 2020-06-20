//
//  WrapLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public class WrapLayout: SetViewLayout {
    var lineSpacing = 0.0
    
    override init() {
        super.init()
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
    }
    
    public func line(spacing: Double) -> Self {
        lineSpacing = spacing
        return self
    }
}

extension WrapLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = WrapLayout()
        copy.subItems = self.subItems.copy(with: zone)
        copy.view = self.view
        copy.attr = self.attr.copy(with: zone)
        copy.lineSpacing = self.lineSpacing
        return copy
    }
}
