//
//  KissTextView.swift
//  Kiss
//
//  Created by Trung on 7/25/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class KissTextView: UITextView {
    var builder = KissTextBuilder()

    public override var text: String? {
        get {
            return attributedText?.string
        }
        set {
            attributedText = builder.attributes(text: newValue)
        }
    }
}

public extension KissTextBuilder {
    func textView() -> KissTextView {
        let textView = KissTextView()
        textView.builder = self
        return textView
    }
}

public class KissTextField: UITextField {
    var builder = KissTextBuilder()

    public override var text: String? {
        get {
            return attributedText?.string
        }
        set {
            attributedText = builder.attributes(text: newValue)
        }
    }
}

public extension KissTextBuilder {
    func textField() -> KissTextField {
        let text = KissTextField()
        text.builder = self

        return text
    }
}
