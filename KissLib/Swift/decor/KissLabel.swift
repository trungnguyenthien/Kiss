//
//  UILabel+Decor.swift
//  Kiss
//
//  Created by Trung on 7/20/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class KissLabel: UILabel {
    var builder = KissTextBuilder()

    public override var text: String? {
        get {
            return attributedText?.string
        }
        set {
            numberOfLines = builder.numberOfLines
            lineBreakMode = builder.paragraph.lineBreakMode
            attributedText = builder.attributes(text: newValue)
        }
    }
}

public extension KissTextBuilder {
    func label() -> KissLabel {
        let label = KissLabel()
        label.builder = self
        label.numberOfLines = numberOfLines
        return label
    }
}
