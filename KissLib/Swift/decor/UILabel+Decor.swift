//
//  UILabel+Decor.swift
//  Kiss
//
//  Created by Trung on 7/20/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol TextDecorable {
    @discardableResult func text(_ string: String) -> Self
    @discardableResult func textColor(_ color: UIColor) -> Self
    /// The font used to display the text (let refer font name at https://github.com/lionhylra/iOS-UIFont-Names)
    @discardableResult func font(name: String, size: CGFloat) -> Self
    /// The font used to display the text.
    @discardableResult func font(_ font: UIFont) -> Self
    /// The font's size used to display the text.
    @discardableResult func fontSize(_ size: CGFloat) -> Self

    @discardableResult func strikethrough(_ style: NSUnderlineStyle, color: UIColor) -> Self
    @discardableResult func strikethrough(_ style: NSUnderlineStyle) -> Self

    @discardableResult func underline(_ style: NSUnderlineStyle) -> Self
    @discardableResult func underline(_ style: NSUnderlineStyle, color: UIColor) -> Self

    @discardableResult func stroke(size: CGFloat, color: UIColor) -> Self
}

struct TextAttribute {
    var textColor: UIColor = .black
    var fontSize: CGFloat = 12
    var fontName: String = "SFUI-Regular"

    var underline: NSUnderlineStyle?
    var underlineColor: UIColor?

    var strikethrough: NSUnderlineStyle?
    var strikethroughColor: UIColor?

    var strokeWidth: CGFloat = 0
    var strokeColor: UIColor?

    func attributes(text: String?) -> NSAttributedString {
        guard let text = text else { return NSAttributedString() }
        guard let font = UIFont(name: fontName, size: fontSize) else {
            fatalError("Font name \"\(fontName)\" isn't supported.")
        }
        let mutableAttribute = NSMutableAttributedString(
            string: text, attributes: [.foregroundColor: textColor, .font: font]
        )

        func addAttr(_ key: NSAttributedString.Key, value: Any) {
            let range = NSRange(location: 0, length: text.count)
            mutableAttribute.addAttribute(key, value: value, range: range)
        }

        if let strikethrough = strikethrough {
            addAttr(.strikethroughColor, value: strikethroughColor ?? textColor)
            addAttr(.strikethroughStyle, value: strikethrough.rawValue)
        }

        if let underline = underline {
            addAttr(.underlineColor, value: underlineColor ?? textColor)
            addAttr(.underlineStyle, value: underline.rawValue)
        }

        if strokeWidth > 0 {
            addAttr(.strokeWidth, value: strokeWidth)
            addAttr(.strokeColor, value: strokeColor ?? textColor)
        }

        return mutableAttribute
    }
}

private var key = "UILabel.textAttribute.Key"

extension UILabel {
    var textAttribute: TextAttribute {
        get {
            guard let obj = objc_getAssociatedObject(self, &key) as? TextAttribute else {
                let attribute = TextAttribute()
                objc_setAssociatedObject(self, &key, attribute, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return attribute
            }
            return obj
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension TextDecorable where Self: UILabel {
    @discardableResult func underline(_ style: NSUnderlineStyle, color: UIColor) -> Self {
        textAttribute.underline = style
        textAttribute.underlineColor = color
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func strikethrough(_ style: NSUnderlineStyle, color: UIColor) -> Self {
        textAttribute.strikethrough = style
        textAttribute.strikethroughColor = color
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func stroke(size: CGFloat, color: UIColor) -> Self {
        textAttribute.strokeWidth = size
        textAttribute.strokeColor = color
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func text(_: String) -> Self {
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func textColor(_ color: UIColor) -> Self {
        textAttribute.textColor = color
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func font(name: String, size: CGFloat) -> Self {
        textAttribute.fontSize = size
        textAttribute.fontName = name
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func font(_ font: UIFont) -> Self {
        textAttribute.fontSize = font.pointSize
        textAttribute.fontName = font.fontName
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func fontSize(_ size: CGFloat) -> Self {
        textAttribute.fontSize = size
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func underline(_ style: NSUnderlineStyle) -> Self {
        textAttribute.underline = style
        textAttribute.underlineColor = nil
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func strikethrough(_ style: NSUnderlineStyle) -> Self {
        textAttribute.strikethrough = style
        textAttribute.strikethroughColor = nil
        attributedText = textAttribute.attributes(text: text)
        return self
    }
}

extension UILabel: TextDecorable {}

public extension String {
    func label() -> UILabel {
        let uilabel = UILabel()
        uilabel.text = self
        return uilabel
    }
}
