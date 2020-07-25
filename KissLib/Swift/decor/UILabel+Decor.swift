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

    // Paragraph Style
    @discardableResult func linebreak(_ mode: LinebreakMode) -> Self

    @discardableResult func firstLineHeadIndent(_ value: CGFloat) -> Self
    @discardableResult func headIndent(_ value: CGFloat) -> Self
    @discardableResult func tailIndent(_ value: CGFloat) -> Self
    @discardableResult func maxLineHeight(_ value: CGFloat) -> Self
    @discardableResult func minLineHeight(_ value: CGFloat) -> Self
    @discardableResult func lineSpacing(_ value: CGFloat) -> Self
    @discardableResult func paragraphSpacing(_ value: CGFloat) -> Self
    @discardableResult func textAlignment(_ value: NSTextAlignment) -> Self
}

public enum LinebreakMode {
    case none
    case wordWrapping(UInt)
    case charWrapping(UInt)
    case clipping(UInt)
    case truncatingHead(UInt)
    case truncatingTail(UInt)
    case truncatingMiddle(UInt)

    var nsLinebreakMode: NSLineBreakMode {
        switch self {
        case .none: return .byTruncatingTail
        case .wordWrapping: return .byWordWrapping
        case .charWrapping: return .byCharWrapping
        case .clipping: return .byClipping
        case .truncatingHead: return .byTruncatingHead
        case .truncatingTail: return .byTruncatingTail
        case .truncatingMiddle: return .byTruncatingMiddle
        }
    }
}

struct TextAttribute {
    var textColor: UIColor = .black
    var fontSize: CGFloat = 12
    var fontName: String = UIFont.systemFont(ofSize: 1).familyName

    var underline: NSUnderlineStyle?
    var underlineColor: UIColor?

    var strikethrough: NSUnderlineStyle?
    var strikethroughColor: UIColor?

    var strokeWidth: CGFloat = 0
    var strokeColor: UIColor?

    // Paragraph Style
//    var alignment = NSTextAlignment.left
//    var firstLineHeadIndent: CGFloat = 0
//    var headIndent: CGFloat = 0
//    var tailIndent: CGFloat = 0
//    var maxLineHeight: CGFloat = 0
//    var minLineHeight: CGFloat = 0
//    var lineSpacing: CGFloat = 0
//    var paragraphSpacing: CGFloat = 0
//    var linebreak = LinebreakMode.none

    var paragraph = NSMutableParagraphStyle()

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

        addAttr(.paragraphStyle, value: paragraph)

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
public extension UILabel {
    internal var textAttribute: TextAttribute {
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

    var kissText: String? {
        get {
            return text
        }
        set {
            text(newValue ?? "")
        }
    }
}

public extension TextDecorable where Self: UILabel {
    @discardableResult func linebreak(_ mode: LinebreakMode) -> Self {
        switch mode {
        case .none:
            numberOfLines = 0
            textAttribute.paragraph.lineBreakMode = .byTruncatingTail
        case let .wordWrapping(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        case let .charWrapping(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        case let .clipping(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        case let .truncatingHead(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        case let .truncatingTail(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        case let .truncatingMiddle(lines):
            numberOfLines = Int(lines)
            textAttribute.paragraph.lineBreakMode = mode.nsLinebreakMode
        }

        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func firstLineHeadIndent(_ value: CGFloat) -> Self {
        textAttribute.paragraph.firstLineHeadIndent = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func headIndent(_ value: CGFloat) -> Self {
        textAttribute.paragraph.headIndent = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func tailIndent(_ value: CGFloat) -> Self {
        textAttribute.paragraph.tailIndent = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func maxLineHeight(_ value: CGFloat) -> Self {
        textAttribute.paragraph.maximumLineHeight = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func minLineHeight(_ value: CGFloat) -> Self {
        textAttribute.paragraph.minimumLineHeight = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func lineSpacing(_ value: CGFloat) -> Self {
        textAttribute.paragraph.lineSpacing = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func paragraphSpacing(_ value: CGFloat) -> Self {
        textAttribute.paragraph.paragraphSpacing = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

    @discardableResult func textAlignment(_ value: NSTextAlignment) -> Self {
        textAttribute.paragraph.alignment = value
        attributedText = textAttribute.attributes(text: text)
        return self
    }

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

    @discardableResult func text(_ text: String) -> Self {
        self.text = text
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
        uilabel.numberOfLines = 0
        return uilabel
    }
}
