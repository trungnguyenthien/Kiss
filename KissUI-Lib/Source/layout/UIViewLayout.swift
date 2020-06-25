//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit
protocol UIViewLayoutSetter: PaddingSetter, EdgeSetter, SizeSetter { }

public class UIViewLayout: LayoutItem, UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var view: UIView? = nil
    var root: UIView? = nil
    func cacheView(forceWidth: Double?, forceHeight: Double?) -> UIView? {
        if forceWidth == attr.width, forceHeight == attr.height {
            return root
        }
        return nil
    }
    
    init() {
        self.attr.userWidth = .fit
        self.attr.userHeight = .fit
    }
    
    public var isVisible: Bool {
        return view?.isVisible == true
    }
    
    var labelContent: UILabel? {
        return view as? UILabel
    }
}

extension UIViewLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = UIViewLayout()
        instance.view = self.view
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        return instance
    }
}

extension UIViewLayout: FlexLayoutItemCreator {
    func flexLayoutItem(forceWidth: Double?, forceHeight: Double?) -> UIView {
        if let cache = cacheView(forceWidth: forceWidth, forceHeight: forceHeight) {
            return cache
        }
        
        attr.width = forceWidth
        attr.height = forceHeight
        
        guard let root = view else { return UIView() }
        
        if let label = root as? UILabel {
            label.frame.size = CGSize(width: .max, height: .max)
            label.sizeToFit()
        }
        
        root.configureLayout { (l) in
            l.isEnabled = true
            self.attr.mapPaddingMarginMaxHeight(to: l)
        }
        
        root.applyLayout(layoutItems: layoutItems, fixWidth: forceWidth, fixHeight: forceHeight)
        
        return root
    }
    
    
}
