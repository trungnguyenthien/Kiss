//
//  HelloWorldView.swift
//  Sample
//
//  Created by Trung on 8/13/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss
import UIBuilder

private func label(_ text: String, _ color: UIColor) -> UILabel {
    let label = TextBuilder()
        .fontSize(72)
        .textColor(color)
        .label().cornerRadius(5)
    label.text = text
    return label
}

class HelloWorldView: UIView {
    lazy var mainLayout = wrap {
        // This is UILabel, you can add any UIView to kiss layout
        label("HELLO ", .red).kiss.layout
        label("WORLD ", .orange).kiss.layout
    }.padding(10).mainAlign(.center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set current layout is mainLayout
        // If you need switch to other layout, let use this method again.
        kiss.constructIfNeed(layout: mainLayout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        kiss.constructIfNeed(layout: mainLayout)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // Update layout for new size
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
