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
    
    private func makeLayout() -> SetViewLayout {
        return  hstack {
               blueView.layout.width(100).height(50)
               label1.layout.leading(10)
               label2.layout.width(.full)
               redView.layout.width(50).height(100)
        }.width(.full).height(.autoFit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blueView)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(redView)
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
