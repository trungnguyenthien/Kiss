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
    
    private var tag1 = hstack {
        "tag1".label.layout
    }.alignStack(.end)
    
    private var tag2 = hstack {
        "tag2".label.layout
        }.alignStack(.end).alignItems(.end)
    
    private lazy var regularLayout = {
        hstack {
            makeView(.blue)
                .layout.width(.grow(1)).height(.ratio(3/2)).marginLeft(100)
                
            
            makeView(.quaternarySystemFill).wrap {
                "0001".label
                    .layout
                "002 Trung".labelBigBold
                    .layout
                makeView(.red)
                    .layout.width(50).height(10).marginLeft(20).alignSelf(.center)
                makeView(.green)
                    .layout.width(40).height(30)
                makeView(.brown)
                    .layout.width(50).height(10)
                makeView(.systemPink)
                    .layout.width(55).height(.ratio(4/2)).marginHorizontal(30)
                    
            }.width(.grow(2)).height(.full).padding(10).alignItems(.center).alignStack(.center)
            
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
