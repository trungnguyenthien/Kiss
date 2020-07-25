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

let myfont = UIFont(name: "AvenirNextCondensed-MediumItalic", size: 14) ?? UIFont.systemFont(ofSize: 14)

enum Builder {
    static var nameText: KissTextBuilder {
        return KissTextBuilder()
        .linebreak(.truncatingTail(2))
        .textColor(.darkGray)
        .underline(.single)
        .style(.italic)
    }
    
    static var bodyText: KissTextBuilder {
        return KissTextBuilder()
        .linebreak(.none)
        .textColor(.black)
        .font(.systemFont(ofSize: 12))
    }
}

class UserKissCell: UICollectionViewCell {
    let mailLabel = Builder.nameText.fontSize(16).label()
    let titleLabel = Builder.bodyText.label()
    let phoneNum =  Builder.bodyText.label()
    let genderLabel =  Builder.bodyText.label()
    
    let imageView = UIView()
        .background(.brown)
        .stroke(size: 2, color: .green)
        .cornerRadius(10)
    
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
