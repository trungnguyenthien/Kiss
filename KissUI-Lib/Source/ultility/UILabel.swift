//
//  UILabel.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyFitSize(attr: LayoutAttribute) {
        if self is UILabel {
            labelFitSize(attr: attr)
        } else {
            defaultViewFitSize(attr: attr)
        }
    }
    
    private func defaultViewFitSize(attr: LayoutAttribute) {
        switch (attr.widthDesignValue, attr.heightDesignValue) {
        case (.autoFit, _), (_, .autoFit):
            sizeToFit()
        default: ()
        }
        
        let fitSize = frame.size
        switch attr.widthDesignValue {
        case .autoFit: attr.expectedWidth = Double(fitSize.width)
        default: ()
        }
        
        switch attr.heightDesignValue {
        case .autoFit: attr.expectedHeight = Double(fitSize.height)
        default: ()
        }
    }
    
    private func labelFitSize(attr: LayoutAttribute) {
        switch (attr.widthDesignValue, attr.heightDesignValue) {
        case (.autoFit, _), (_, .autoFit):
            frame.size.width = CGFloat(Double.max)
            frame.size.height = CGFloat(Double.max)
            sizeToFit()
        default: ()
        }
        
        let fitSize = frame.size
        switch attr.widthDesignValue {
        case .autoFit: attr.expectedWidth = Double(fitSize.width)
        default: ()
        }
        
        switch attr.heightDesignValue {
        case .autoFit: attr.expectedHeight = Double(fitSize.height)
        default: ()
        }
    }
}
