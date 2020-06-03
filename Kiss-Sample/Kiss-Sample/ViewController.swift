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
        let wrap = label.hstack(
            label.layout,
            hspacer, /* |--| */
            label.layout,
            vstack(
                
            )
        ).padding(10)
        
    }


}

let small = 4.0
let medium = 8.0


func compactLayout(baseWidth: Double) -> SetViewLayout {
    return vstack (
        // Product thumbnail
        UIImageView().layout.widthFull(equalHeight: 5/3),
        vstack (
            UILabel().debug("1000$").layout.left(medium).top(small).size(.zero),
            UILabel().layout.left(medium).top(small).widthFull(height: 15),
            UILabel().layout.left(medium).top(small).widthFull(height: 15),
            UILabel().layout.left(medium).top(small).widthFull(height: 15)
        ).top(medium).widthFull(height: .fit).min(width: 300).hAlign(.right),
        wrap ( // List tags attribute
            UILabel().layout.size(.zero).left(small),
            UILabel().layout.width(100, height: 20).left(small),
            UILabel().layout.width(100, height: 20).left(small),
            UILabel().layout.width(100, height: 20).left(small)
        ).line(spacing: small).top(small).widthFill(1, height: 200)
    ).width(baseWidth, height: .fit).padding(medium)
}

