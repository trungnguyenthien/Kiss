//
//  uiFactory.swift
//  Sample
//
//  Created by Trung on 7/17/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

enum Typo {
    case caption
    case footnote
    case subhead
    case callout
    case body
    case title3
    case title2
    case title1
    case largeTitle
    
    var font: UIFont {
        switch self {
        case .caption: return .systemFont(ofSize: 11, weight: .medium)
        case .footnote: return .systemFont(ofSize: 12, weight: .medium)
        case .subhead: return .systemFont(ofSize: 14, weight: .medium)
        case .callout: return .systemFont(ofSize: 15, weight: .medium)
        case .body: return .systemFont(ofSize: 16, weight: .medium)
        case .title3: return .systemFont(ofSize: 19, weight: .medium)
        case .title2: return .systemFont(ofSize: 21, weight: .medium)
        case .title1: return .systemFont(ofSize: 27, weight: .medium)
        case .largeTitle: return .systemFont(ofSize: 33, weight: .medium)
        }
    }
}

func makeButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .systemOrange
    button.layer.cornerRadius = 15
    return button
}

func makeThumbnail() -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .lightGray
    imageView.layer.cornerRadius = 5
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = UIColor.gray.cgColor
    return imageView
}

func makeIconImage(name: String, size: Double) -> UIImageView {
    let imageView = UIImageView()
    imageView.image = UIImage(named: name)
    imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
    return imageView
}

func makeView(_ color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
}

extension String {
    var button: UIButton {
        let btn = makeButton()
        btn.setTitle(self, for: .normal)
        return btn
    }
    
    func label(_ typo: Typo) -> UILabel {
        let view = UILabel()
        view.font = typo.font
        view.text = self
        view.numberOfLines = 0
        return view
    }
}
