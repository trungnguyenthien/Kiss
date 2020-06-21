//
//  AlignmentSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public protocol AlignmentSetter {
    func align(vertical value: AlignVertical) -> Self
    func align(horizontal value: AlignHorizontal) -> Self
}

public extension AlignmentSetter where Self: LayoutItem {
    func align(vertical value: AlignVertical) -> Self {
        attr.verticalAlignment = value
        return self
    }
    
    func align(horizontal value: AlignHorizontal) -> Self {
        attr.horizontalAlignment = value
        return self
    }
}
