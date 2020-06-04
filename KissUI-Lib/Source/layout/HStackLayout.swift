//
//  HStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class HStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
    
}

extension LayoutSubviewsAble where Self: HStackLayout {
    public func makeSizeSubviews(width: Double) {
        
    }
    
    public func layoutSubviews(width: Double) {
        
    }
}
