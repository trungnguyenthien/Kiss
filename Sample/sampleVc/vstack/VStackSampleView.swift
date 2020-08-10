//
//  VStackSampleView.swift
//  Sample
//
//  Created by Trung on 8/8/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss
import UIBuilder
//https://yogalayout.com/docs
class VStackSampleView: UIView {
    let blueView = view(.blue)
    let redView = view(.red)
    let greenView = view(.green)
    let uiswitch = UISwitch()
    let text1 = large(text: "Vertical Stack Layout", line: 2).background(.orange)
    
    lazy var layout1 = vstack {
        blueView.kiss.layout.height(40).margin(5)
        uiswitch.kiss.layout
        text1.kiss.layout.margin(5)
        redView.kiss.layout.grow(1).margin(5)
        greenView.kiss.layout.growFull().ratio(1/1).margin(5)
    }.padding(10)
    
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
//
//  VStackSampleView.swift
//  Sample
//
//  Created by Trung on 8/10/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
