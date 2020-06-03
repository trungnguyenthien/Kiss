//
//  vstack.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public class VStack: ViewLayout, AlignmentSetter {
    var subLayouts = [ViewLayout]()
    override init() {
        super.init()
        self.isControl = false
    }
}

public class HStack: ViewLayout, AlignmentSetter {
    var subLayouts = [ViewLayout]()
    override init() {
        super.init()
        self.isControl = false
    }
}

public class Wrap: ViewLayout, AlignmentSetter {
    var subLayouts = [ViewLayout]()
    override init() {
        super.init()
        self.isControl = false
    }
}

public class ViewLayout: LayoutAttribute, PaddingSetter, AnchorSetter {
    var view: UIView? = nil
    override init() {
        super.init()
        self.isControl = true
    }
}

public class VSpacer: LayoutAttribute {
    public override init() {
        super.init()
        self.widthValue = .value(0.5)
        self.heightValue = .fill(1)
        self.isControl = true
    }
}

public class HSpacer: LayoutAttribute {
    public override init() {
        super.init()
        self.heightValue = .value(0.5)
        self.widthValue = .fill(1)
        self.isControl = true
    }
}
