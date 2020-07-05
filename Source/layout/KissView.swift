//
//  KissView.swift
//  Kiss
//
//  Created by Trung on 7/5/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

open class KissView: UIView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
    
    public override var intrinsicContentSize: CGSize {
        return kiss.estimatedSize()
    }
    
    open override func sizeToFit() {
        kiss.updateChange()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return kiss.estimatedSize(width: size.width, height: size.height)
    }
}
