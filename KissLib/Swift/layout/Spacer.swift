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
    
    init() {
        attr.grow = -.sameZero
    }
    
    init(grow: Double) {
        attr.grow = grow
    }
    
    init(size: Double) {
        attr.userWidth = size
        attr.userHeight = size
    }
    
    public var isVisibleLayout: Bool {
        return true
    }
}

extension Spacer: FlexLayoutItemProtocol {
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
            if let grow = self.attr.grow {
                setGrow(grow: grow, to: l)
            }
        }
    }
    
    func prepareForRenderingLayout() {
        
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


