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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "Hello world, Nguyen Thien Trung, Nguyen Thi Phuong THao, 1 2 3 4 5 6 7 8 9 0 0 -"
        label.font = UIFont.systemFont(ofSize: 16)
//        label.preferredMaxLayoutWidth = 100
        label.frame.size.width = 100
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
//        label.layoutIfNeeded()
        print("Frame = \(label.frame)")
        
        
        label.font = UIFont.systemFont(ofSize: 20)
//        label.preferredMaxLayoutWidth = 150
        label.frame.size.width = CGFloat.greatestFiniteMagnitude
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
//        label.layoutIfNeeded()
        print("Frame = \(label.frame)")
    }
}

let small = 4.0
let medium = 8.0

var compactLayout =
vstack { // Product thumbnail
    UIImageView().layout
    vspacer /* |---| */
    vstack { /* Vertical Stack */
        "Nguyen".labelMedium.layout.top(small)
        " THIEN".labelSmall.layout.top(small)
        " trung----".labelBigBold.layout.top(small)
        UILabel().layout.leading(medium).top(small)
    }.top(medium).min(width: 300).hAlign(.right)
    wrap { // List tags attribute
        UILabel().layout.size(.zero).leading(small)
        UILabel().layout.leading(small)
        UILabel().layout.leading(small)
        UILabel().layout.leading(small)
    }.line(spacing: small).top(small)
}.padding(medium)

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
