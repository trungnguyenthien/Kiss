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
        
        compactLayout
            .width(300, height: .fit)
            .layoutSubviews(width: 300)
        
    }
}

let small = 4.0
let medium = 8.0


var compactLayout =
    vstack { // Product thumbnail
        UIImageView().layout.widthFull(equalHeight: 5/3).id("image")
        vspacer /* |---| */
        vstack { /* Vertical Stack */
            "Nguyen".labelMedium.layout.top(small).widthFull(height: 40).id("lable1")
            " THIEN".labelSmall.layout.top(small).width(200, height: 20).id("lable2")
            " trung----".labelBigBold.layout.top(small).widthFull(height: 15).id("lable3")
            UILabel().layout.left(medium).top(small).widthFull(height: 15).id("lable4")
        }.top(medium).widthFull(height: .fit).min(width: 300).hAlign(.right).id("vstack1")
        zstack { // List tags attribute
            UILabel().layout.size(.zero).left(small).id("lable5")
            UILabel().layout.width(100, height: 20).left(small).id("lable6")
            UILabel().layout.width(100, height: 20).left(small).id("lable7")
            UILabel().layout.width(100, height: 20).left(small).id("lable8")
        }.line(spacing: small).top(small).widthFill(1, height: 200).id("wrap")
    }.padding(medium).id("vstackLv0")

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
