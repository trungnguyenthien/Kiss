//
//  MixLayoutView.swift
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
        .fontSize(32)
        .textColor(color)
        .textAlignment(.center)
        .label().cornerRadius(5)
    label.text = text
    return label
}

private func box(
    _ width: Double,
    _ height: Double,
    _ color: UIColor = MaterialColor.blue600
) -> Kiss.UIViewLayout {
    return view(color).cornerRadius(4)
        .kiss.layout.margin(5).size(width, height)
}


class MixLayoutView: UIView {
    var box1 = view(.black)
    var box2 = view(.red)
    lazy var mainLayout =  vstack {
        label("Let try new layout solution", MaterialColor.red700)
            .kiss.layout.margin(10)
        
        view(MaterialColor.green600)
            .cornerRadius(5).stroke(size: 1, color: .brown)
            .kiss.layout.crossAlign(self: .stretch).height(100).margin(10)
        
        view(.green).kiss.hstack {
            box1.kiss.layout.size(50, 20).margin(5)
            box2.kiss.layout.size(50, 50).margin(5)
            }.mainAlign(.center).autoInvisible(.allInvisible).padding(20)
        
        view(MaterialColor.pink500)
            .cornerRadius(5).stroke(size: 1, color: .brown)
            .kiss.layout.crossAlign(self: .stretch).height(50).margin(10)
    }.padding(10)
    
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
        
        let willHiddenBox12 = frame.width > frame.height
        box1.isHidden = willHiddenBox12
        box2.isHidden = willHiddenBox12
        
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
