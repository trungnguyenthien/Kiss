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

let small = 5.0
let medium = 10.0


let myLayout = hstack (
    UIImageView().layout.widthFull(equalHeight: 5/3),
    hstack (
        UILabel().layout.left(medium).top(small),
        UILabel().layout.left(medium).top(small),
        UILabel().layout.left(medium).top(small),
        UILabel().layout.left(medium).top(small)
    )
).width(200, height: .fit).padding(medium)
