//
//  UserKissCell.swift
//  Sample
//
//  Created by Trung on 7/5/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import Kiss

class UserKissCell: UICollectionViewCell {
    let mailLabel = "ngthientrung@gmail.com".label(.body)
    let titleLabel = "My Title".label(.body)
    let phoneNum = "(+84) 167 767 0064".label(.body)
    let genderLabel = "Gender: Male".label(.body)
    let imageView = makeThumbnail()
    let ratingView = RatingView()
    let button = "Detail info".button
    
    lazy var stackInfoLayout = vstack {
        mailLabel.kiss.layout.marginTop(5)
        ratingView.kiss.layout.marginTop(5).height(30)
        titleLabel.kiss.layout.marginTop(5)
        stretchSpacer()
        phoneNum.kiss.layout.marginTop(5)
        genderLabel.kiss.layout
        button.kiss.layout.margin(5)
    }
    
    lazy var hLayout = hstack {
        imageView.kiss.layout.grow(1).ratio(1/1)
        spacer(10)
        stackInfoLayout.cloned.grow(1)
    }.padding(10).crossAlign(items: .start)
    
    lazy var vLayout = vstack {
        imageView.kiss.layout.crossAlign(self: .stretch).ratio(2/2)
        spacer(10)
        stackInfoLayout.cloned.growFull()
    }.padding(10).crossAlign(items: .start)
    
    func config(user: User, isPortrait: Bool) {
        backgroundColor = .white
        mailLabel.text = user.email
        titleLabel.text = "\(user.name.last) \(user.name.first)"
        phoneNum.text = "Tel: \(user.phone)"
        genderLabel.text = user.gender.rawValue
        genderLabel.isVisible = user.gender == .male
        ratingView.isVisible = user.gender == .female
        
        kiss.constructIfNeed(layout: isPortrait ? vLayout : hLayout)
        kiss.updateChange(width: frame.size.width, height: frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
