//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
    }
}

extension VStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = VStackLayout()
        instance.subItems = self.subItems.copy(with: zone)
        instance.view = self.view
        instance.attr = self.attr.copy(with: zone)
        return instance
    }
}
