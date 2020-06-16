//
//  PaddingSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol PaddingSetter {
    func padding(_ value: Double) -> Self
    func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self
}

public extension PaddingSetter where Self: ViewLayout {
    func padding(_ value: Double) -> Self {
        attr.paddingTop = value
        attr.paddingBottom = value
        attr.paddingLeft = value
        attr.paddingRight = value
        return self
    }
    
    func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self {
        attr.paddingTop = top
        attr.paddingBottom = bottom
        attr.paddingLeft = left
        attr.paddingRight = right
        return self
    }
}
