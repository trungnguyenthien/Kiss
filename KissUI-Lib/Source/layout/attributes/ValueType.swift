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
    case fillRemain(Int8)
    case none
}

public enum WidthValue {
    case fillRemain(Int8)
    case full
}

public enum DesignHeightValue {
    case value(Double)
    case fit
    // height / width
    case equalWidth(Double)
    case fillRemain(Int8)
    case none
}

public enum HeightValue {
    case fit
    case full
    // height / width
    case equalWidth(Double)
    case fillRemain(Int8)
}

public enum HorizontalAlignmentValue {
    case left
    case right
    case center
}

public enum VerticalAlignmentValue {
    case bottom
    case top
    case center
}
