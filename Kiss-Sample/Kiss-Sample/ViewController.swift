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
        
        compactLayout(baseWidth: 300).layoutSubviews(width: 300)
        
    }


}

let small = 4.0
let medium = 8.0


func compactLayout(baseWidth: Double) -> SetViewLayout {
    return vstack (
        // Product thumbnail
        UIImageView().layout.widthFull(equalHeight: 5/3).id("image"),
        vstack (
            UILabel().layout.left(medium).top(small).widthFull(height: 40).id("lable1"),
            UILabel().layout.left(medium).top(small).widthFull(height: 15).id("lable2"),
            UILabel().layout.left(medium).top(small).widthFull(height: 15).id("lable3"),
            UILabel().layout.left(medium).top(small).widthFull(height: 15).id("lable4")
            ).top(medium).widthFull(height: .fit).min(width: 300).hAlign(.right).id("vstack1"),
        wrap ( // List tags attribute
            UILabel().layout.size(.zero).left(small).id("lable5"),
            UILabel().layout.width(100, height: 20).left(small).id("lable6"),
            UILabel().layout.width(100, height: 20).left(small).id("lable7"),
            UILabel().layout.width(100, height: 20).left(small).id("lable8")
            ).line(spacing: small).top(small).widthFill(1, height: 200).id("wrap")
    ).width(baseWidth, height: .fit).padding(medium).id("vstackLv0")
}

