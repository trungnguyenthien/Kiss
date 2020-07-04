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
    private let grow: Double
    
    init() {
        grow = -.sameZero
    }
    
    init(_ grow: Double) {
        self.grow = grow
    }
    
    public var isVisible: Bool {
        return true
    }
}

extension Spacer: FlexLayoutItemProtocol {
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
            setGrow(grow: self.grow, to: l)
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


