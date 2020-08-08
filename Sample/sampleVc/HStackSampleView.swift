//
//  HStackSampleView.swift
//  Sample
//
//  Created by Trung on 8/8/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss
import UIBuilder
class HStackSampleView: UIView {
    let blueView = view(.blue)
    let redView = view(.red)
    let greenView = view(.green)
    let text1 = medium(text: "Horizontal Stack Layout", line: 2).background(.orange)
    lazy var layout1 = hstack {
        blueView.kiss.layout.height(100).grow(1).margin(5)
        text1.kiss.layout.grow(2).margin(5).crossAlign(self: .start)
        redView.kiss.layout.height(100).grow(1).margin(5)
        greenView.kiss.layout.height(150).grow(1).margin(5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        kiss.constructIfNeed(layout: layout1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        kiss.constructIfNeed(layout: layout1)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }

    public override var intrinsicContentSize: CGSize {
        kiss.estimatedSize()
    }

    open override func sizeToFit() {
        kiss.updateChange()
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        kiss.estimatedSize(width: size.width, height: size.height)
    }
}
