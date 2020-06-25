//
//  WrapLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class WrapLayout: GroupLayout {
    var lineSpacing = 0.0
    var cacheView: UIView? = nil
    func cacheView(forceWidth: Double?, forceHeight: Double?) -> UIView? {
        if forceWidth == attr.width, forceHeight == attr.height {
            return cacheView
        }
        return nil
    }
    override init() {
        super.init()
        self.attr.userWidth = .grow(.max)
        self.attr.userHeight = .fit
    }
    
    public func line(spacing: Double) -> Self {
        lineSpacing = spacing
        return self
    }
}

extension WrapLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = WrapLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.lineSpacing = self.lineSpacing
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

extension WrapLayout: FlexLayoutItemCreator {
    func flexLayoutItem(forceWidth: Double?, forceHeight: Double?) -> UIView {
        if let cache = cacheView(forceWidth: forceWidth, forceHeight: forceHeight) {
            return cache
        }
        return UIView()
    }
}
