//
//  WrapSampleView.swift
//  Sample
//
//  Created by Trung on 8/11/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss
import UIBuilder

private func makeTag(_ text: String) -> UILabel {
    let label = large(text: "| \(text) |", line: 1)
        .background(MaterialColor.grey100)
        .stroke(size: 1, color: MaterialColor.black)
    return label
}

class WrapSampleView: UIView {
    let tag1 = makeTag("Black")
    let tag2 = makeTag("LightGreen")
    let tag3 = makeTag("Orange")
    let tag4 = makeTag("DarkRed")
    let tag5 = makeTag("Red")
    
    let view1 = view(.blue)
    let view2 = view(.red)
    let view3 = view(.green)
    
    lazy var layout1 = wrap {
        tag1.kiss.layout.margin(10)
        tag2.kiss.layout.margin(10)
        // Align bottom of line
        view1.kiss.layout.width(100).height(20).margin(10).crossAlign(self: .end)
        tag3.kiss.layout.margin(10)
        tag4.kiss.layout.margin(10)
        view2.kiss.layout.width(100).height(40).margin(10)
        tag5.kiss.layout.margin(10)
        // Align center of line
        view3.kiss.layout.width(50).height(20).margin(10).crossAlign(self: .center)
    }.padding(10).mainAlign(.center)
    
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
