//
//  LayoutArrangeAble.swift
//  KissUI
//
//  Created by Trung on 6/9/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol LayoutArrangeAble {
    func arrangeLayout()
}

public func render(layout: ViewLayout) {
    if layout.view == nil {
        throwError("Thuộc tính view của MainLayout đang nil")
    }
    _render(layout: layout)
}

private func _render(layout: ViewLayout) {
    _1_add_TempSpacer_To_SelfLayout_For_AutoAlignment(viewLayout: layout)
    _2_apply_AutoFitWidth_For_Label(viewLayout: layout)
    _3_apply_FixWidth_For_SubLayout(viewLayout: layout)
    _4_apply_GrowWidth_For_SubLayout_And_Spacer(viewLayout: layout)
    _5_apply_FixHeight_To_SubLayout(viewLayout: layout)
    _6_apply_FitHeight_To_SubLayout(viewLayout: layout)
    _7_apply_GrowHeight_To_SubLayout(viewLayout: layout)
    _8_apply_Frame_To_SubLayout(viewLayout: layout)
    _9_apply_SelfHeight(viewLayout: layout)
    _10_reCheck(viewLayout: layout)
}

private func _1_add_TempSpacer_To_SelfLayout_For_AutoAlignment(viewLayout: ViewLayout) {
    guard let setViewLayout = viewLayout as? SetViewLayout, isVisibledLayout(setViewLayout) else { return }
    setViewLayout.subLayouts.removeAll { $0 is _TemptSpacer }
    
    switch setViewLayout.horizontalAlignment {
    case .left:
        setViewLayout.subLayouts.insert(temptSpacer, at: 0)
    
    case .right:
        setViewLayout.subLayouts.append(temptSpacer)
        
    case .center:
        setViewLayout.subLayouts.append(temptSpacer)
        setViewLayout.subLayouts.insert(temptSpacer, at: 0)
    }
    
    switch setViewLayout.verticalAlignment {
    case .top:
        setViewLayout.subLayouts.insert(temptSpacer, at: 0)
    
    case .bottom:
        setViewLayout.subLayouts.append(temptSpacer)
        
    case .center:
        setViewLayout.subLayouts.append(temptSpacer)
        setViewLayout.subLayouts.insert(temptSpacer, at: 0)
    }
}

private func _2_apply_AutoFitWidth_For_Label(viewLayout: ViewLayout) {
    guard let label = viewLayout.view as? UILabel, isVisibledLayout(viewLayout) else { return }
    label.applyFitSize(attr: viewLayout)
}

private func _3_apply_FixWidth_For_SubLayout(viewLayout: ViewLayout) {
    guard let setViewLayout = viewLayout as? SetViewLayout, isVisibledLayout(viewLayout) else { return }
    setViewLayout.subLayouts.filter { isVisibledLayout($0) }.forEach {
        switch $0.widthDesignValue {
        case .value(let size): $0.expectedWidth = size
        case .grow(_): ()
        case .autoFit: ()
        }
    }
}

//private func _4_applyFitWidthForSubLayout() {
//
//}

private func _4_apply_GrowWidth_For_SubLayout_And_Spacer(viewLayout: ViewLayout) {
    guard isVisibledLayout(viewLayout) else { return }

    // HSTACK ONLY
    if let hstack = viewLayout as? HStackLayout {
        var remainWidth = viewLayout.expectedWidth ?? 0
        remainWidth -= viewLayout.paddingLeft
        remainWidth -= viewLayout.paddingRight
        var sumPart = 0.0
        hstack.subLayouts.forEach {
            if $0 is ViewLayout, !isVisibledLayout($0) { return }
            remainWidth -= $0.expectedWidth ?? 0
            switch $0.widthDesignValue {
            case .grow(let part): sumPart += part
            default: ()
            }
        }
        
        hstack.subLayouts.forEach {
            if $0 is ViewLayout, !isVisibledLayout($0) { return }
            switch $0.widthDesignValue {
            case .grow(let part):
                let growWidth = remainWidth * part / sumPart
                $0.expectedWidth = growWidth
            default: ()
            }
        }
    }
    
    // VSTACK ONLY
    if let vstack = viewLayout as? VStackLayout {
        var remainWidth = viewLayout.expectedWidth ?? 0
        remainWidth -= viewLayout.paddingLeft
        remainWidth -= viewLayout.paddingRight
        vstack.subLayouts.forEach {
            guard $0 is ViewLayout, isVisibledLayout($0) else { return }
            switch $0.widthDesignValue {
            case .grow(let part):
                if part != .max {
                    printWarning("Trong VStack không thể gán thuộc tính width(.grow), sẽ ép về width(.full)")
                    $0.widthDesignValue = .grow(.max)
                }
                $0.expectedWidth = remainWidth
                
            default: ()
            }
        }
    }
    
    // WRAP ONLY
    if let wrap = viewLayout as? WrapLayout {
        wrap.subLayouts
            .compactMap { $0 as? ViewLayout }
            .filter { isVisibledLayout($0) }
            .forEach {
                switch $0.widthDesignValue {
                case .grow(_) where $0.view is UILabel:
                    printWarning("Trong Wrap không thể gán thuộc tính width(.grow), sẽ ép về width(.autoFit)")
                    $0.widthDesignValue = .autoFit
                    
                case .grow(_):
                    throwError("Trong Wrap không thể gán width(.grow)")
                    
                default: ()
                }
            }
    }
}

private func _5_apply_FixHeight_To_SubLayout(viewLayout: ViewLayout) {
    guard let setLayout = viewLayout as? SetViewLayout, isVisibledLayout(viewLayout) else { return }
    setLayout.subLayouts.forEach {
        guard isVisibledLayout($0) else { return }
        switch $0.heightDesignValue {
        case .value(let size):
            $0.expectedHeight = size
        case .widthPerHeightRatio(let ratio):
            guard let eWidth = $0.expectedWidth else {
                throwError("Khi sử dụng height(.widthPerHeightRatio), thì width phải là .value/.grow/.autoFit (nếu là Label)")
                return
            }
            $0.expectedHeight = eWidth / ratio
        case .autoFit: ()
        case .grow(_): ()
        }
    }
}

private func _6_apply_FitHeight_To_SubLayout(viewLayout: ViewLayout) {
    
}

private func _7_apply_GrowHeight_To_SubLayout(viewLayout: ViewLayout) {
    
}

private func _8_apply_Frame_To_SubLayout(viewLayout: ViewLayout) {
    
}

private func _9_apply_SelfHeight(viewLayout: ViewLayout) {
    
}

private func _10_reCheck(viewLayout: ViewLayout) {
    
}
