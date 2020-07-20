//
//  UILabel+Decor.swift
//  Kiss
//
//  Created by Trung on 7/20/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol TextDecorator {
    @discardableResult func text(_ string: String) -> Self
    @discardableResult func textColor(_ color: UIColor) -> Self
    @discardableResult func fontSize(_ size: CGFloat) -> Self
    @discardableResult func fontName(_ name: String) -> Self
}

public extension TextDecorator where Self: UILabel {
    @discardableResult func text(_ string: String) -> Self {
        text = string
        return self
    }

    @discardableResult func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }

    @discardableResult func fontSize(_ size: CGFloat) -> Self {
        guard let current = font else { return self }
        font = current.withSize(size)
        return self
    }

    @discardableResult func fontName(_ name: String) -> Self {
        guard let size = font?.pointSize else { return self }
        font = UIFont(name: name, size: size)
        return self
    }
}

extension UILabel: TextDecorator {}

public extension String {
    func label() -> UILabel {
        let uilabel = UILabel()
        uilabel.text = self
        return uilabel
    }
}
