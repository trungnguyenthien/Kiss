//
//  PaddingSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol PaddingSetter {
    func padding(size: Double) -> Self
    func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self
}

extension PaddingSetter where Self: LayoutAttribute {
    public func padding(size: Double) -> Self {
        paddingTop = size
        paddingBottom = size
        paddingLeft = size
        paddingRight = size
        return self
    }
    
    public func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self {
        paddingTop = top
        paddingBottom = bottom
        paddingLeft = left
        paddingRight = right
        return self
    }
}
