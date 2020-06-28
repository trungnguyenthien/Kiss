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
    
    private lazy var regularLayout = {
        self.view.hstack {
            makeView(.blue).layout.width(100).height(100)
            
            makeView(.yellow).vstack {
                "0001".label.layout.width(.fit).marginRight(100)
                "002 Trung".label.layout.width(.fit)
                makeView(.red).layout.width(.full).height(100).marginLeft(20)
                makeView(.green).layout.width(200).height(30)
            }.width(.full).height(.full)
            
        }.padding(12)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regularLayout.constructLayout()
    }
    
    override func viewWillLayoutSubviews() {
        regularLayout.updateLayoutChange(width: view.bounds.width - 100, height: nil)
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
