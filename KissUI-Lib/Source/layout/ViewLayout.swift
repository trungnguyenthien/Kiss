//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class ViewLayout: LayoutAttribute, PaddingSetter, AnchorSetter, SizeSetter {
    var view: UIView? = nil
    override init() {
        super.init()
        self.isControl = true
    }
    
    public override func layoutSubviews(width: Double) {
        traceClassName(self, message: "layoutSubviews")
        makeSizeSubviews(width: width)
    }
    
    public override func makeSizeSubviews(width: Double) {
        traceClassName(self, message: "makeSizeSubviews width=\(width)")
        switch widthDesignValue {
        case .value(let wvalue): expectedWidth = wvalue
        case .fill(_): expectedWidth = width
        }
        
        switch heightDesignValue {
        case .value(let hvalue): expectedHeight = hvalue
        case .equalWidth(let e): expectedHeight = (expectedWidth ?? 0) * e
        case .fit: ()
        case .fill(_): ()
        }
        
        traceClassName(self, message: "width=\(expectedWidth), height=\(expectedHeight)")
    }
}
