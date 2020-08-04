//
//  Array+Extension.swift
//
//  Created by Trung on 7/15/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

extension Array {
    func element(_ index: Int) -> Element? {
        if index < 0 || index >= count { return nil }
        return self[index]
    }

    var firstIndex: Int {
        0
    }

    var lastIndex: Int {
        count - 1
    }
}
