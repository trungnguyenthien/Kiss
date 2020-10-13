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
import UIBuilder

let myfont = UIFont(name: "AvenirNextCondensed-MediumItalic", size: 14) ?? UIFont.systemFont(ofSize: 14)

enum Builder {
    static var nameText: TextBuilder {
        return TextBuilder()
            .font(myfont)
            .linebreak(.truncatingTail(2))
            .textColor(.darkGray)
            .underline(.single)
            .style(.italic)
    }
    
    static var infoText: TextBuilder {
        return TextBuilder()
            .linebreak(.none)
            .textColor(.black)
            .font(.systemFont(ofSize: 12))
    }
    
    static func thumbnail() -> UIImageView {
        return UIImageView()
            .cornerRadius(15)
            .background(.lightGray)
            .stroke(size: 2, color: .green)
    }
}

class UserKissCell: UICollectionViewCell {
    let mailLabel = Builder.nameText.fontSize(20).label()
    let titleLabel = Builder.infoText.label()
    let phoneNum =  Builder.infoText.textView()
    let imageView = Builder.thumbnail()
    
    let ratingView = RatingView()
    let button = "Detail info".button
    
    lazy var mainView = view(.clear)
    
    lazy var stackInfoLayout = vstack {
        mailLabel.kiss.layout.marginTop(5)
        ratingView.kiss.layout.marginTop(5).height(30)
        titleLabel.kiss.layout.marginTop(5)
        stretchSpacer()
        phoneNum.kiss.layout.marginTop(5)
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
    
    func config(user: UserCellModel, isPortrait: Bool) {
        backgroundColor = .white
        mailLabel.text = user.email
        titleLabel.text = user.title
        phoneNum.text = user.phone
        ratingView.isVisible = !user.isMale
        
        kiss.constructIfNeed(layout: isPortrait ? vLayout : hLayout)
        kiss.updateChange(width: frame.size.width, height: frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
