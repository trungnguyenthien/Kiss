//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class ViewLayout: PaddingSetter, EdgeSetter, SizeSetter, LayoutItem {
    var attr = LayoutAttribute()
    var view: UIView? = nil
    init() {
        self.attr.widthDesignValue = .autoFit
        self.attr.heightDesignValue = .autoFit
    }
    
    var labelContent: UILabel? {
        return view as? UILabel
    }
}

extension ViewLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = ViewLayout()
        instance.view = self.view
        instance.attr = self.attr.copy(with: zone)
        return instance
    }
}
