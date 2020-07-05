//
//  RatingView.swift
//  Sample
//
//  Created by Trung on 7/5/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss

private let imageName = "ic_star"
private let iconSize: Double = 24

class RatingView: KissView {
    
    private let star1 = makeIconImage(name: imageName, size: iconSize)
    private let star2 = makeIconImage(name: imageName, size: iconSize)
    private let star3 = makeIconImage(name: imageName, size: iconSize)
    private let star4 = makeIconImage(name: imageName, size: iconSize)
    private let star5 = makeIconImage(name: imageName, size: iconSize)
    
    private lazy var bodyLayout = hstack {
        star1.layout.marginRight(5).size(iconSize, iconSize)
        star2.layout.marginRight(5).size(iconSize, iconSize)
        star3.layout.marginRight(5).size(iconSize, iconSize)
        star4.layout.marginRight(5).size(iconSize, iconSize)
        star5.layout.marginRight(5).size(iconSize, iconSize)
    }.alignItems(.start)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        kiss.constructIfNeed(layout: bodyLayout)
    }
    
    init() {
        super.init(frame: .zero)
        kiss.constructIfNeed(layout: bodyLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
