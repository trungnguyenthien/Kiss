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
    func makeSubLayout()
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

func _1_add_TempSpacer_To_SelfLayout_For_AutoAlignment(viewLayout: ViewLayout) {
    guard let setViewLayout = viewLayout as? SetViewLayout else { return }
    setViewLayout.subItems.removeAll { $0 is _TemptSpacer }
    
    switch setViewLayout.attr.horizontalAlignment {
    case .left:
        setViewLayout.subItems.insert(temptSpacer, at: 0)
    
    case .right:
        setViewLayout.subItems.append(temptSpacer)
        
    case .center:
        setViewLayout.subItems.append(temptSpacer)
        setViewLayout.subItems.insert(temptSpacer, at: 0)
    }
    
    switch setViewLayout.attr.verticalAlignment {
    case .top:
        setViewLayout.subItems.insert(temptSpacer, at: 0)
    
    case .bottom:
        setViewLayout.subItems.append(temptSpacer)
        
    case .center:
        setViewLayout.subItems.append(temptSpacer)
        setViewLayout.subItems.insert(temptSpacer, at: 0)
    }
}

func _2_apply_AutoFitWidth_For_Label(viewLayout: ViewLayout) {
    guard let label = viewLayout.view as? UILabel else { return }
    label.applyFitSize(attr: viewLayout.attr)
}

func _3_apply_FixWidth_For_SubLayout(viewLayout: ViewLayout) {
    guard let setViewLayout = viewLayout as? SetViewLayout else { return }
    setViewLayout.subItems.forEach {
        switch $0.attr.widthDesignValue {
        case .value(let size): $0.attr.expectedWidth = size
        case .grow(_): ()
        case .autoFit: ()
        }
    }
}

//private func _4_applyFitWidthForSubLayout() {
//
//}

func _4_apply_GrowWidth_For_SubLayout_And_Spacer(viewLayout: ViewLayout) {

    // HSTACK ONLY
    if let hstack = viewLayout as? HStackLayout {
        var remainWidth = viewLayout.attr.expectedWidth ?? 0
        remainWidth -= viewLayout.attr.paddingLeft
        remainWidth -= viewLayout.attr.paddingRight
        var sumPart = 0.0
        hstack.subItems.forEach {
            remainWidth -= $0.attr.expectedWidth ?? 0
            switch $0.attr.widthDesignValue {
            case .grow(let part): sumPart += part
            default: ()
            }
        }
        
        hstack.subItems.forEach {
            switch $0.attr.widthDesignValue {
            case .grow(let part):
                let growWidth = remainWidth * part / sumPart
                $0.attr.expectedWidth = growWidth
            default: ()
            }
        }
    }
    
    // VSTACK ONLY
    if let vstack = viewLayout as? VStackLayout {
        var remainWidth = viewLayout.attr.expectedWidth ?? 0
        remainWidth -= viewLayout.attr.paddingLeft
        remainWidth -= viewLayout.attr.paddingRight
        vstack.subItems.forEach {
            switch $0.attr.widthDesignValue {
            case .grow(let part):
                if part != .max {
                    printWarning("Trong VStack không thể gán thuộc tính width(.grow), sẽ ép về width(.full)")
                    $0.attr.widthDesignValue = .grow(.max)
                }
                $0.attr.expectedWidth = remainWidth
                
            default: ()
            }
        }
    }
    
    // WRAP ONLY
    if let wrap = viewLayout as? WrapLayout {
        wrap.subItems
            .forEach {
                switch $0.attr.widthDesignValue {
                case .grow(_) where $0.view is UILabel:
                    printWarning("Trong Wrap không thể gán thuộc tính width(.grow), sẽ ép về width(.autoFit)")
                    $0.attr.widthDesignValue = .autoFit
                    
                case .grow(_):
                    throwError("Trong Wrap không thể gán width(.grow)")
                    
                default: ()
                }
            }
    }
}

func _5_apply_FixHeight_To_SubLayout(viewLayout: ViewLayout) {
    guard let setLayout = viewLayout as? SetViewLayout else { return }
    setLayout.subItems.forEach {
        switch $0.attr.heightDesignValue {
        case .value(let size):
            $0.attr.expectedHeight = size
        case .whRatio(let ratio):
            guard let eWidth = $0.attr.expectedWidth else {
                throwError("Khi sử dụng height(.widthPerHeightRatio), thì width phải là .value/.grow/.autoFit (nếu là Label)")
                return
            }
            $0.attr.expectedHeight = eWidth / ratio
        case .autoFit: ()
        case .grow(_): ()
        }
    }
}

func _6_apply_FitHeight_To_SubLayout(viewLayout: ViewLayout) {
    switch viewLayout.attr.heightDesignValue {
    case .autoFit: ()
    default: return
    }
    
    var selfHeight = 0.0
    selfHeight += viewLayout.attr.paddingTop
    selfHeight += viewLayout.attr.paddingBottom
    
    if isLabelLayout(attr: viewLayout)  {
        selfHeight += Double(viewLayout.labelContent?.frame.height ?? 0)
        viewLayout.attr.expectedHeight = selfHeight
    } else if let setLayout = viewLayout as? SetViewLayout, !hasAllSubFrame(setLayout) {
        setLayout.subItems.compactMap { $0 as? LayoutArrangeAble }.forEach { $0.makeSubLayout() }
        if let fitSize = fitSizeSetLayout(of: viewLayout) {
            selfHeight += Double(fitSize.height)
            viewLayout.attr.expectedHeight = selfHeight
        }
    }
    reUpdateExpectedHeightByMinHeight(viewLayout)
}

private func reUpdateExpectedHeightByMinHeight(_ attr: LayoutItem) {
    guard let height = attr.attr.expectedHeight, let minHeight = attr.attr.minHeight else { return }
    attr.attr.expectedHeight = max(height, minHeight)
}

func _7_apply_GrowHeight_To_SubLayout(viewLayout: ViewLayout) {
    
    if let vstack = viewLayout as? VStackLayout {
        var remainHeight = 0.0
        remainHeight -= vstack.attr.paddingBottom
        remainHeight -= vstack.attr.paddingTop
        let visibleLayout = vstack.subItems.filter { !isSpacer($0) }
        visibleLayout.enumerated().forEach { (index, layout) in
            let startIndex = 0
            let endIndex = visibleLayout.count - 1
                
            if index > startIndex { remainHeight -= layout.attr.top }
            remainHeight -= layout.attr.expectedHeight ?? 0.0
            if index < endIndex { remainHeight -= layout.attr.bottom }
        }
        var sumPart = 0.0
        vstack.subItems.filter { isSpacer($0) }.forEach {
            switch $0.attr.heightDesignValue {
            case .grow(let part):
                sumPart += part
                
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
        }
        
        vstack.subItems.filter { isSpacer($0) }.forEach {
            switch $0.attr.heightDesignValue {
            case .grow(let part):
                let height = remainHeight * part / sumPart
                $0.attr.expectedHeight = height
                
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
            reUpdateExpectedHeightByMinHeight($0)
        }
    }
    
    if let hstack = viewLayout as? HStackLayout {
        var remainHeight = 0.0
        remainHeight -= hstack.attr.paddingBottom
        remainHeight -= hstack.attr.paddingTop
        var maxHeight = 0.0
        let visibleLayout = hstack.subItems.filter { !isSpacer($0) }
        visibleLayout.forEach {
            switch $0.attr.heightDesignValue {
            case .grow(_):
                printWarning("Khi sử dụng height(.grow) trong HStack sẽ tự ép về height(.full)")
                $0.attr.heightDesignValue = .grow(.max)
            
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
            maxHeight = max(maxHeight, $0.attr.expectedHeight ?? 0.0)
        }
        
        visibleLayout.forEach {
            switch $0.attr.heightDesignValue {
            case .grow(_):
                $0.attr.expectedHeight = maxHeight
            
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
            
        }
    }

    
    if let wrap = viewLayout as? WrapLayout {
        let visibleLayout = wrap.subItems.filter { !isSpacer($0) }
        visibleLayout.forEach {
            switch $0.attr.heightDesignValue {
            case .grow(_): throwError("Trong Wrap không sử dụng width(.grow), width(.full), height(.grow), height(.full)")
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
        }
    }
}

private func _8_apply_Frame_To_SubLayout(viewLayout: ViewLayout) {
    
}

private func _9_apply_SelfHeight(viewLayout: ViewLayout) {
    
}

func _10_reCheck(viewLayout: ViewLayout) -> Bool {
    return false
}

/// ----------------------------------------------------------------------


func fitSizeSetLayout(of layout: LayoutItem) -> CGSize? {
    
    if let setViewLayout = layout as? SetViewLayout {
        var minX = Double.max
        var minY = Double.max
        var maxX = Double.min
        var maxY = Double.min
        
        setViewLayout.subItems.forEach { (attr) in
            guard !isSpacer(attr) else { return }
            if let subExpectedX = attr.attr.expectedX {
                minX = min(minX, subExpectedX)
                if let subExpectedWidth = attr.attr.expectedWidth {
                    maxX = max(maxX, subExpectedX + subExpectedWidth)
                }
            }
            
            if let subExpectedY = attr.attr.expectedY {
                minY = min(minY, subExpectedY)
                if let subExpectedHeight = attr.attr.expectedHeight {
                    maxY = max(maxY, subExpectedY + subExpectedHeight)
                }
            }
        }
        if minX == .max || minY == .max || maxX == .min || maxY == .min {
            return nil
        }
        return CGSize(width: maxX - minX + layout.attr.paddingLeft + layout.attr.paddingRight,
                      height: maxY - minY + layout.attr.paddingBottom + layout.attr.paddingTop)
    }
    
    return .zero
}

func transitFrame(viewLayout: ViewLayout, newX: Double, newY: Double) {
    if viewLayout.attr.expectedX == nil {
        viewLayout.attr.expectedX = newX
    }
    
    if viewLayout.attr.expectedY == nil {
        viewLayout.attr.expectedY = newY
    }
    
    guard let setViewLayout = viewLayout as? SetViewLayout else { return }
    let dx = newX - (viewLayout.attr.expectedX ?? 0)
    let dy = newY - (viewLayout.attr.expectedY ?? 0)
    
    setViewLayout.subItems.forEach { (subLayout) in
        var newX = subLayout.attr.expectedX ?? 0
        if let currentX = subLayout.attr.expectedX {
            newX = currentX + dx
        }
        var newY = subLayout.attr.expectedY ?? 0
        if let currentY = subLayout.attr.expectedY {
            newY = currentY + dy
        }
        
        if let layout = subLayout as? ViewLayout {
            transitFrame(viewLayout: layout, newX: newX, newY: newY)
        }
    }
}

private func isSpacer(_ attr: LayoutItem) -> Bool {
    return attr is Spacer
}

private func isLabelLayout(attr: ViewLayout) -> Bool {
    return attr.view is UILabel
}

private func hasSelfSize(_ selfLayout: LayoutAttribute) -> Bool {
    if selfLayout is Spacer { return true }
    return selfLayout.expectedWidth != nil && selfLayout.expectedHeight != nil
}

private func hasSelfFrame(_ selfLayout: LayoutItem) -> Bool {
    if selfLayout is Spacer { return true }
    return selfLayout.attr.expectedWidth.notNil &&
        selfLayout.attr.expectedHeight.notNil &&
        selfLayout.attr.expectedX.notNil &&
        selfLayout.attr.expectedY.notNil
}

func hasAllSubFrame(_ selfLayout: LayoutItem) -> Bool {
    if let setLayout = selfLayout as? SetViewLayout {
        return setLayout.subItems.reduce(true) { previous, currentLayout in
            previous && hasAllSubFrame(currentLayout)
        }
    } else {
        return hasSelfFrame(selfLayout)
    }
}
