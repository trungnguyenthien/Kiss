//
//  ViewController.swift
//  Kiss-Sample
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import UIKit
import KissUI

class ViewController: UIViewController {

    private let collectionView = makeCollection()
    
    private lazy var regularLayout = {
        vstack {
            collectionView.layout.width(.full)
        }.padding(12)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.kiss.constructIfNeed(layout: regularLayout)
    }
    
    override func viewDidLayoutSubviews() {
        view.kiss.updateChange(width: view.bounds.width - 10, height: nil)
    }
}

let small = 4.0
let medium = 8.0

func makeCollection() -> UICollectionView {
    return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
}


func makeView(_ color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
}

extension String {
    var label: UILabel {
        let view = UILabel()
        view.text = self
        view.backgroundColor = .cyan
        return view;
    }
    
    var labelSmall: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 8, weight: .medium)
        return label
    }
    
    var labelMedium: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }
    
    var labelBigBold: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }
}
