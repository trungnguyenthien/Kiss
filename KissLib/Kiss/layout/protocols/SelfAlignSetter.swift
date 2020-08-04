//
//  SelfAlignSetter.swift
//
//  Created by Trung on 6/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public enum SelfAlign {
    case none, start, end, center, stretch
}

public protocol SelfAlignSetter {
    @discardableResult func selfAlign(_ value: CrossAxisAlignment) -> Self
}

public extension SelfAlignSetter where Self: LayoutItem {
    func selfAlign(_ value: CrossAxisAlignment) -> Self {
        attr.alignSelf = value
        return self
    }
}
