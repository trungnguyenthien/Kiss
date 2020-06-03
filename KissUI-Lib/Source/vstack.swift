//
//  vstack.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class SetViewLayout: ViewLayout, AlignmentSetter {
    var subLayouts = [LayoutAttribute]()
}

public class VStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
}

public class HStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
}

public class WrapLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
}

public class ViewLayout: LayoutAttribute, PaddingSetter, AnchorSetter, SizeSetter {
    var view: UIView? = nil
    override init() {
        super.init()
        self.isControl = true
    }
}

public class VSpacer: LayoutAttribute {
    override init() {
        super.init()
        self.widthValue = .value(0.5)
        self.heightValue = .fill(1)
        self.isControl = true
    }
}

public class HSpacer: LayoutAttribute {
    override init() {
        super.init()
        self.heightValue = .value(0.5)
        self.widthValue = .fill(1)
        self.isControl = true
    }
}
