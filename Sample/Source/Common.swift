//
//  Common.swift
//  Kiss-Sample
//
//  Created by Trung on 6/30/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

let small = 4.0
let medium = 8.0

func isPortrait() -> Bool {
    return UIScreen.main.bounds.width < UIScreen.main.bounds.height
}

func makeCollection() -> UICollectionView {
    let clayout = UICollectionViewFlowLayout.init()
    clayout.scrollDirection = .vertical
    let collection = UICollectionView(frame: .zero, collectionViewLayout: clayout)
    collection.alwaysBounceVertical = true
    collection.isUserInteractionEnabled = true
    return collection
}


func makeView(_ color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
}

extension String {
    var label: UILabel {
        let view = UILabel()
        view.backgroundColor = .quaternarySystemFill
        view.text = self
        view.numberOfLines = 0
        return view;
    }
    
    var labelSmall: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }
    
    var labelMedium: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    var labelMediumBold: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }
    
    var labelBigBold: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }
}
