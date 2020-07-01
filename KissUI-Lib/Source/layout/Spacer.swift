//
//  Spacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class Spacer: LayoutItem {
    var attr = LayoutAttribute()
    var body = makeBlankView()
    
    public var isVisible: Bool {
        return true
    }
}

extension Spacer: FlexLayoutItemProtocol {
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
            setGrow(grow: -0.000000000001, to: l)
        }
    }
    
    func layoutRendering() {
        
    }
}

extension Spacer: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = Spacer()
        instance.attr = self.attr
        instance.body = self.body
        return instance
    }
}


