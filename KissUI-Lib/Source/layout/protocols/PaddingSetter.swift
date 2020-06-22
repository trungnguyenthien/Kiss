//
//  PaddingSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol PaddingSetter {
    @discardableResult func padding(_ value: Double) -> Self
    @discardableResult func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self
}

public extension PaddingSetter where Self: LayoutItem {
    func padding(_ value: Double) -> Self {
        attr.userPaddingTop = value
        attr.userPaddingBottom = value
        attr.userPaddingLeft = value
        attr.userPaddingRight = value
        return self
    }
    
    func padding(top: Double, bottom: Double, left: Double, right: Double) -> Self {
        attr.userPaddingTop = top
        attr.userPaddingBottom = bottom
        attr.userPaddingLeft = left
        attr.userPaddingRight = right
        return self
    }
}
