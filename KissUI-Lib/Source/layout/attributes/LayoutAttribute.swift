//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

typealias KFloat = Double

public class LayoutAttribute {
    var isControl = true
    var paddingLeft: KFloat = 0 // internal(set)
    var paddingRight: KFloat = 0
    var paddingTop: KFloat = 0
    var paddingBottom: KFloat = 0
    
    var leading: KFloat = 0
    var trailing: KFloat = 0
    
    var top: KFloat = 0
    var bottom: KFloat = 0
    
    var widthDesignValue = DesignWidthValue.fillRemain(1)
    var heightDesignValue = DesignHeightValue.fit
    
    var minWidth: KFloat? = nil
    var minHeight: KFloat? = nil
    
    var expectedWidth: KFloat? = nil
    var expectedHeight: KFloat? = nil
    var expectedX: KFloat? = nil
    var expectedY: KFloat? = nil
    
    var verticalAlignment: VerticalAlignmentValue = .top
    var horizontalAlignment: HorizontalAlignmentValue = .left
    
    var id = ""
    
    public func id(_ id: String) -> Self {
        self.id = id
        return self
    }
    
    
    // ------ //
    func applySelfWidth() {
        switch widthDesignValue {
        case .value(let size):
            expectedWidth = size
        case .fit: ()
        case .fillRemain: ()
        }
    }
    
    func applySelfHeight(selfWidth: KFloat) {
        
    }
    
    func applySubsWidth(selfWidth: KFloat) {
        // HSTACK
        guard let setViewLayout = self as? SetViewLayout else { return }
        let visibledLayouts = setViewLayout.subLayouts.filter { isVisibledLayout($0) }
        var sumPart: Double = 0
        var remainWidth = selfWidth
        remainWidth -= paddingLeft
        remainWidth -= paddingRight
        
        visibledLayouts.forEach { (subLayout) in
            switch(subLayout.widthDesignValue) {
            case .value, .fit:
                subLayout.applySelfWidth()
            case .fillRemain(let part):
                sumPart += part
            }
            remainWidth -= subLayout.expectedWidth ?? 0
            remainWidth -= subLayout.leading - subLayout.trailing
        }

        visibledLayouts.forEach { (subLayout) in
            guard subLayout.expectedWidth == nil else { return }
            switch(subLayout.widthDesignValue) {
            case .value, .fit: ()
            case .fillRemain(let part):
                subLayout.expectedWidth = remainWidth * part / sumPart
            }
        }
    }
    
    func applySubFrames() {
        
    }
}
