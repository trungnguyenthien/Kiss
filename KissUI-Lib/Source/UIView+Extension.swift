//
//  UIView+Extension.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    var vstack: VStack {
        let stack = VStack()
        stack.view = self
        return stack
    }
    
    var hstack: HStack {
        let stack = HStack()
        stack.view = self
        return stack
    }
    
    var wrap: Wrap {
        let wrap = Wrap()
        wrap.view = self
        return wrap
    }
    
    var layout: ViewLayout {
        let vlayout = ViewLayout()
        vlayout.view = self
        return vlayout
    }
}


