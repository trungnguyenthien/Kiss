//
//  KissTextBuilder.swift
//  Kiss
//
//  Created by Trung on 7/25/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol TextDecorable {
    /// Use this attribute to specify the color of the text during rendering.
    /// If you do not specify this attribute, the text is rendered in black.
    @discardableResult func textColor(_ color: UIColor) -> Self

    /// The font used to display the text
    /// (let refer font name at https://github.com/lionhylra/iOS-UIFont-Names)
    @discardableResult func font(name: String, size: CGFloat) -> Self

    /// The font used to display the text.
    @discardableResult func font(_ font: UIFont) -> Self

    /// The font's size used to display the text.
    @discardableResult func fontSize(_ size: CGFloat) -> Self

    /// Applies a strikethrough to the text.
    @discardableResult func strikethrough(_ style: NSUnderlineStyle, color: UIColor) -> Self

    /// Applies a strikethrough to the text.
    @discardableResult func strikethrough(_ style: NSUnderlineStyle) -> Self

    /// Applies an underline to the text.
    @discardableResult func underline(_ style: NSUnderlineStyle) -> Self

    /// Applies an underline to the text.
    @discardableResult func underline(_ style: NSUnderlineStyle, color: UIColor) -> Self

    /// Applies an stroke to the text.
    /// - Parameters:
    ///   - size: This value is specified as a percentage of the font point size. Specify 0 (the default) for no additional changes.
    ///   - color: stroke's color
    @discardableResult func stroke(size: CGFloat, color: UIColor) -> Self

    // Paragraph Style
    /// The mode that should be used to break lines in the receiver.
    @discardableResult func linebreak(_ mode: LinebreakMode) -> Self

    /// The indentation of the first line of the receiver.
    @discardableResult func firstLineHeadIndent(_ value: CGFloat) -> Self

    /// The indentation of the receiver’s lines other than the first.
    @discardableResult func headIndent(_ value: CGFloat) -> Self

    /// The trailing indentation of the receiver.
    @discardableResult func tailIndent(_ value: CGFloat) -> Self

    /// The receiver’s maximum line height.
    @discardableResult func maxLineHeight(_ value: CGFloat) -> Self

    /// The receiver’s minimum height.
    @discardableResult func minLineHeight(_ value: CGFloat) -> Self

    /// The distance in points between the bottom of one line fragment and the top of the next.
    @discardableResult func lineSpacing(_ value: CGFloat) -> Self

    /// The space after the end of the paragraph.
    @discardableResult func paragraphSpacing(_ value: CGFloat) -> Self

    /// The text alignment of the receiver.
    @discardableResult func textAlignment(_ value: NSTextAlignment) -> Self

    /// TextStyle: regular, italic, bold, boldItalic
    @discardableResult func style(_ value: TextStyle) -> Self
}

public enum TextStyle {
    case regular
    case italic
    case bold
    case boldItalic
}

public enum LinebreakMode {
    case none
    /// Wrapping occurs at word boundaries, unless the word itself doesn’t fit on a single line.
    case wordWrapping(Int)

    /// Wrapping occurs before the first character that doesn’t fit.
    case charWrapping(Int)

    /// Lines are simply not drawn past the edge of the text container.
    case clipping(Int)

    /// The line is displayed so that the end fits in the container and the missing text
    /// at the beginning of the line is indicated by an ellipsis glyph.
    /// Although this mode works for multiline text, it is more often used for single line text.
    case truncatingHead(Int)

    /// The line is displayed so that the beginning fits in the container and the missing text
    /// at the end of the line is indicated by an ellipsis glyph.
    ///  Although this mode works for multiline text, it is more often used for single line text.
    case truncatingTail(Int)

    /// The line is displayed so that the beginning and end fit in the container
    /// and the missing text in the middle is indicated by an ellipsis glyph.
    /// This mode is used for single-line layout; using it with multiline text truncates the text into a single line.
    case truncatingMiddle(Int)

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

    var numberOfLines: Int {
        switch self {
        case .none: return 0
        case let .wordWrapping(lines): return lines
        case let .charWrapping(lines): return lines
        case let .clipping(lines): return lines
        case let .truncatingHead(lines): return lines
        case let .truncatingTail(lines): return lines
        case let .truncatingMiddle(lines): return lines
        }
    }
}

extension UIFont {
    private func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: pointSize)
    }

    var italic: UIFont { with(traits: .traitItalic) }
    var bold: UIFont { with(traits: .traitBold) }
    var boldItalic: UIFont { with(traits: [.traitBold, .traitItalic]) }
}

public struct KissTextBuilder {
    var textColor: UIColor = .black
    var fontSize: CGFloat = 12
    var fontName: String = UIFont.systemFont(ofSize: 1).familyName
    var underline: NSUnderlineStyle?
    var underlineColor: UIColor?
    var strikethrough: NSUnderlineStyle?
    var strikethroughColor: UIColor?
    var strokeWidth: CGFloat = 0
    var strokeColor: UIColor?
    var numberOfLines: Int = 0
    var textStyle = TextStyle.regular
    var paragraph = NSMutableParagraphStyle()

    public init() {}

    func attributes(text: String?) -> NSAttributedString {
        guard let text = text else { return NSAttributedString() }

        guard var font = UIFont(name: fontName, size: fontSize) else {
            fatalError("Font name \"\(fontName)\" isn't supported.")
        }

        switch textStyle {
        case .regular: ()
        case .italic:
            font = font.italic
        case .bold:
            font = font.bold
        case .boldItalic:
            font = font.boldItalic
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

extension KissTextBuilder: TextDecorable {
    @discardableResult public func style(_ value: TextStyle) -> Self {
        var copy = self
        copy.textStyle = value
        return copy
    }

    @discardableResult public func linebreak(_ mode: LinebreakMode) -> Self {
        var copy = self
        copy.numberOfLines = Int(mode.numberOfLines)
        copy.paragraph.lineBreakMode = mode.nsLinebreakMode
        return copy
    }

    @discardableResult public func firstLineHeadIndent(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.firstLineHeadIndent = value
        return copy
    }

    @discardableResult public func headIndent(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.headIndent = value
        return copy
    }

    @discardableResult public func tailIndent(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.tailIndent = value
        return copy
    }

    @discardableResult public func maxLineHeight(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.maximumLineHeight = value
        return copy
    }

    @discardableResult public func minLineHeight(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.minimumLineHeight = value
        return copy
    }

    @discardableResult public func lineSpacing(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.lineSpacing = value
        return copy
    }

    @discardableResult public func paragraphSpacing(_ value: CGFloat) -> Self {
        let copy = self
        copy.paragraph.paragraphSpacing = value
        return copy
    }

    @discardableResult public func textAlignment(_ value: NSTextAlignment) -> Self {
        let copy = self
        copy.paragraph.alignment = value
        return copy
    }

    @discardableResult public func underline(_ style: NSUnderlineStyle, color: UIColor) -> Self {
        var copy = self
        copy.underline = style
        copy.underlineColor = color
        return copy
    }

    @discardableResult public func strikethrough(_ style: NSUnderlineStyle, color: UIColor) -> Self {
        var copy = self
        copy.strikethrough = style
        copy.strikethroughColor = color
        return copy
    }

    @discardableResult public func stroke(size: CGFloat, color: UIColor) -> Self {
        var copy = self
        copy.strokeWidth = size
        copy.strokeColor = color
        return copy
    }

    @discardableResult public func textColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }

    @discardableResult public func font(name: String, size: CGFloat) -> Self {
        var copy = self
        copy.fontSize = size
        copy.fontName = name
        return copy
    }

    @discardableResult public func font(_ font: UIFont) -> Self {
        var copy = self
        copy.fontSize = font.pointSize
        copy.fontName = font.fontName
        return copy
    }

    @discardableResult public func fontSize(_ size: CGFloat) -> Self {
        var copy = self
        copy.fontSize = size
        return copy
    }

    @discardableResult public func underline(_ style: NSUnderlineStyle) -> Self {
        var copy = self
        copy.underline = style
        copy.underlineColor = nil
        return copy
    }

    @discardableResult public func strikethrough(_ style: NSUnderlineStyle) -> Self {
        var copy = self
        copy.strikethrough = style
        copy.strikethroughColor = nil
        return copy
    }
}
