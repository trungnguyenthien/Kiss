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
    let blueView = makeView(.blue)
    let label1 = "0001".label
    let label2 = "002 Trung".label
    let redView = makeView(.red)
    
    private lazy var regularLayout = {
        self.view.hstack {
            blueView.layout.width(40).height(.whRatio(4/3))
            label1.layout.width(.fit).marginRight(100)
            label2.layout.width(.fit)
            spacer
            redView.layout.width(50).height(100)
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regularLayout.constructLayout()
    }
    
    override func viewWillLayoutSubviews() {
        regularLayout.updateLayoutChange(width: view.bounds.width, height: nil)
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
