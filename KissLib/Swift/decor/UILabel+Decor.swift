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
    func text(_ string: String) -> Self
    func textColor(_ color: UIColor) -> Self
    func fontSize(_ size: CGFloat) -> Self
    func fontName(_ name: String) -> Self
}

extension TextDecorator where Self: UILabel {
    public func text(_ string: String) -> Self {
        text = string
        return self
    }

    public func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }

    public func fontSize(_ size: CGFloat) -> Self {
        guard let current = font else { return self }
        font = current.withSize(size)
        return self
    }

    public func fontName(_ name: String) -> Self {
        guard let size = font?.pointSize else { return self }
        font = UIFont(name: name, size: size)
        return self
    }
}

public extension String {
    func label() -> UILabel {
        let uilabel = UILabel()
        uilabel.text = self
        return uilabel
    }
}
