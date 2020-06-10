//
//  public.swift
//  KissUI
//
//  Created by Trung on 6/1/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

public enum DesignWidthValue {
    case value(Double)
    case grow(Double)
    case autoFit
}

public enum WidthValue {
    case grow(Double)
    case full
    case autoFit
}

public enum DesignHeightValue {
    case value(Double)
    case autoFit
    // height / width
    case equalWidth(Double)
    case grow(Double)
}

public enum HeightValue {
    case autoFit
    case full
    // height / width
    case equalWidth(Double)
    case grow(Double)
}

public enum AlignHorizontal {
    case left, right, center
}

public enum AlignVertical {
    case bottom, top, center
}

public enum AlignItem {
    case start, end, center, stretch
}

public enum AlignContent {
    case start, end, center, stretch
}
