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

public extension PaddingSetter where Self: LayoutAttribute {
    func padding(_ value: Double) -> Self {
        paddingTop = value
        paddingBottom = value
        paddingLeft = value
        paddingRight = value
        return self
    }
    
    func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self {
        paddingTop = top
        paddingBottom = bottom
        paddingLeft = left
        paddingRight = right
        return self
    }
}
