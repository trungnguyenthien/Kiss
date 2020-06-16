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
        self.attr.widthDesignValue = .grow(.max)
        self.attr.heightDesignValue = .autoFit
    }
}

extension HStackLayout: LayoutArrangeAble {
    func makeSubLayout() {
         _1_add_TempSpacer_To_SelfLayout_For_AutoAlignment(viewLayout: self)
        _2_apply_AutoFitWidth_For_Label(viewLayout: self)
    }
}
