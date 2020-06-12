//
//  HSpacer.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


class _TemptSpacer: Spacer {
    override init() {
        super.init()
        self.heightDesignValue = .grow(.sameZero)
        self.widthDesignValue = .grow(.sameZero)
    }
    
}

