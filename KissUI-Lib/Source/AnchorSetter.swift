//
//  AnchorSetter.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public protocol AnchorSetter {
    func left(_ value: Double) -> Self
    func right(_ value: Double) -> Self
    func top(_ value: Double) -> Self
    func bottom(_ value: Double) -> Self
}

extension AnchorSetter where Self: LayoutAttribute {
    func left(_ value: Double) -> Self {
        leading = value
        return self
    }
    func right(_ value: Double) -> Self {
        trailing = value
        return self
    }
    func top(_ value: Double) -> Self {
        top = value
        return self
    }
    func bottom(_ value: Double) -> Self {
        bottom = value
        return self
    }
}
