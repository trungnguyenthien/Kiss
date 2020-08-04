//
//  IconLabel.swift
//  Kiss
//
//  Created by Trung on 7/21/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

private extension UIImage {
    func image(scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

struct LabelIcon {
    enum Align {
        case top, center, bottom
    }

    let image: UIImage
    let size: CGSize
    let align: Align

    init(image: UIImage, align: Align = .bottom, size: CGFloat) {
        self.image = image
        self.align = align
        self.size = CGSize(width: size, height: size)
    }

    init(image: UIImage, align: Align = .bottom, width: CGFloat, height: CGFloat) {
        self.image = image
        self.align = align
        size = CGSize(width: width, height: height)
    }

    init(image: String, align: Align = .bottom, width: CGFloat, height: CGFloat) {
        self.image = UIImage(named: image)!
        self.align = align
        size = CGSize(width: width, height: height)
    }
}

class IconLabel: UILabel {
    let iconLeft: LabelIcon?
    let iconRight: LabelIcon?

    init(leftIcon: LabelIcon? = nil, rightIcon: LabelIcon? = nil) {
        iconLeft = leftIcon
        iconRight = rightIcon
        super.init(frame: .zero)
    }

    required init?(coder _: NSCoder) { // swiftlint:disable:this unavailable_function
        fatalError("init(coder:) has not been implemented")
    }

    private func attachment(icon: LabelIcon) -> NSTextAttachment {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = icon.image.image(scaledTo: icon.size)
        switch icon.align {
        case .top: imageAttachment.bounds = CGRect(x: 0, y: icon.size.height, width: icon.size.width, height: icon.size.height)
        case .center: imageAttachment.bounds = CGRect(x: 0, y: -icon.size.height / 2, width: icon.size.width, height: icon.size.height)
        case .bottom: imageAttachment.bounds = CGRect(x: 0, y: -icon.size.height, width: icon.size.width, height: icon.size.height)
        }
        return imageAttachment
    }

    private func makeAttrText() {
        let fullText = NSMutableAttributedString()
        if let icon = iconLeft {
            let attributeString = NSAttributedString(attachment: attachment(icon: icon))
            fullText.append(attributeString)
        }

//        if let text = text {
//
//            let attrString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : font!]?)
//            fullText.append(attrString)
//        }

        if let icon = iconRight {
            let attributeString = NSAttributedString(attachment: attachment(icon: icon))
            fullText.append(attributeString)
        }
    }
}
