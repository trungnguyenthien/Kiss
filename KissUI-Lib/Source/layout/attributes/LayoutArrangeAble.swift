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
    switch viewLayout.heightDesignValue {
    case .autoFit: ()
    default: return
    }
    
    var selfHeight = 0.0
    selfHeight += viewLayout.paddingTop
    selfHeight += viewLayout.paddingBottom
    
    if isLabelLayout(attr: viewLayout), isVisibledLayout(viewLayout) {
        selfHeight += Double(viewLayout.labelContent?.frame.height ?? 0)
        viewLayout.expectedHeight = selfHeight
    } else if let setLayout = viewLayout as? SetViewLayout, !hasAllSubFrame(setLayout) {
        setLayout.subLayouts.compactMap { $0 as? LayoutArrangeAble }.forEach { $0.arrangeLayout() }
        if let fitSize = fitSizeSetLayout(of: viewLayout) {
            selfHeight += Double(fitSize.height)
            viewLayout.expectedHeight = selfHeight
        }
    }
    reUpdateExpectedHeightByMinHeight(viewLayout)
}

private func reUpdateExpectedHeightByMinHeight(_ attr: LayoutAttribute) {
    guard let height = attr.expectedHeight, let minHeight = attr.minHeight else { return }
    attr.expectedHeight = max(height, minHeight)
}

private func _7_apply_GrowHeight_To_SubLayout(viewLayout: ViewLayout) {
    
    if let vstack = viewLayout as? VStackLayout {
        var remainHeight = 0.0
        remainHeight -= vstack.paddingBottom
        remainHeight -= vstack.paddingTop
        let visibleLayout = vstack.subLayouts.filter { isVisibledLayout($0) && !isSpacer($0) }
        visibleLayout.enumerated().forEach { (index, layout) in
            let startIndex = 0
            let endIndex = visibleLayout.count - 1
                
            if index > startIndex { remainHeight -= layout.top }
            remainHeight -= layout.expectedHeight ?? 0.0
            if index < endIndex { remainHeight -= layout.bottom }
        }
        var sumPart = 0.0
        vstack.subLayouts.filter { isVisibledLayout($0) || isSpacer($0) }.forEach {
            switch $0.heightDesignValue {
            case .grow(let part):
                sumPart += part
                
            case .value(_): ()
            case .autoFit: ()
            case .widthPerHeightRatio(_): ()
            }
        }
        
        vstack.subLayouts.filter { isVisibledLayout($0) || isSpacer($0) }.forEach {
            switch $0.heightDesignValue {
            case .grow(let part):
                let height = remainHeight * part / sumPart
                $0.expectedHeight = height
                
            case .value(_): ()
            case .autoFit: ()
            case .widthPerHeightRatio(_): ()
            }
        }
    }
    
    if let hstack = viewLayout as? HStackLayout {
        var remainHeight = 0.0
        remainHeight -= hstack.paddingBottom
        remainHeight -= hstack.paddingTop
        
        let visibleLayout = hstack.subLayouts.filter { isVisibledLayout($0) && !isSpacer($0) }
        visibleLayout.forEach {
            switch $0.heightDesignValue {
            case .grow(_):
            
            case .value(_): ()
            case .autoFit: ()
            case .widthPerHeightRatio(_): ()
            }
        }
    }
    

    
    if let wrap = viewLayout as? WrapLayout {
        
    }
}

private func _8_apply_Frame_To_SubLayout(viewLayout: ViewLayout) {
    
}

private func _9_apply_SelfHeight(viewLayout: ViewLayout) {
    
}

private func _10_reCheck(viewLayout: ViewLayout) {
    
}

/// ----------------------------------------------------------------------


func allLayoutAttributes(from layout: LayoutAttribute) -> [LayoutAttribute] {
    var output = [LayoutAttribute]()
    if let setlayout = layout as? SetViewLayout {
        output.append(setlayout)
        output.append(contentsOf: allLayoutAttributes(from: setlayout))
    } else {
        output.append(layout)
    }
    return output
}

func fitSizeSetLayout(of layout: LayoutAttribute) -> CGSize? {
    guard isVisibledLayout(layout) else { return .zero }
    
    if let setViewLayout = layout as? SetViewLayout {
        var minX = Double.max
        var minY = Double.max
        var maxX = Double.min
        var maxY = Double.min
        
        setViewLayout.subLayouts.forEach { (attr) in
            guard isVisibledLayout(attr) && !isSpacer(attr) else { return }
            if let subExpectedX = attr.expectedX {
                minX = min(minX, subExpectedX)
                if let subExpectedWidth = attr.expectedWidth {
                    maxX = max(maxX, subExpectedX + subExpectedWidth)
                }
            }
            
            if let subExpectedY = attr.expectedY {
                minY = min(minY, subExpectedY)
                if let subExpectedHeight = attr.expectedHeight {
                    maxY = max(maxY, subExpectedY + subExpectedHeight)
                }
            }
        }
        if minX == .max || minY == .max || maxX == .min || maxY == .min {
            return nil
        }
        return CGSize(width: maxX - minX + layout.paddingLeft + layout.paddingRight,
                      height: maxY - minY + layout.paddingBottom + layout.paddingTop)
    }
    
    return .zero
}

func transitFrame(viewLayout: ViewLayout, newX: Double, newY: Double) {
    if viewLayout.expectedX == nil {
        viewLayout.expectedX = newX
    }
    
    if viewLayout.expectedY == nil {
        viewLayout.expectedY = newY
    }
    
    guard let setViewLayout = viewLayout as? SetViewLayout else { return }
    let dx = newX - (viewLayout.expectedX ?? 0)
    let dy = newY - (viewLayout.expectedY ?? 0)
    
    setViewLayout.subLayouts.forEach { (subLayout) in
        var newX = subLayout.expectedX ?? 0
        if let currentX = subLayout.expectedX {
            newX = currentX + dx
        }
        var newY = subLayout.expectedY ?? 0
        if let currentY = subLayout.expectedY {
            newY = currentY + dy
        }
        
        if let layout = subLayout as? ViewLayout {
            transitFrame(viewLayout: layout, newX: newX, newY: newY)
        }
    }
}

private func isSpacer(_ attr: LayoutAttribute) -> Bool {
    return attr is Spacer
}

private func isLabelLayout(attr: LayoutAttribute) -> Bool {
    guard let layout = attr as? ViewLayout, layout.view is UILabel else { return false }
    return true
}

private func hasSelfSize(_ selfLayout: LayoutAttribute) -> Bool {
    if selfLayout is Spacer { return true }
    return selfLayout.expectedWidth != nil && selfLayout.expectedHeight != nil
}

private func hasSelfFrame(_ selfLayout: LayoutAttribute) -> Bool {
    if selfLayout is Spacer { return true }
    return selfLayout.expectedWidth.notNil &&
        selfLayout.expectedHeight.notNil &&
        selfLayout.expectedX.notNil &&
        selfLayout.expectedY.notNil
}

func hasAllSubFrame(_ selfLayout: LayoutAttribute) -> Bool {
    guard isVisibledLayout(selfLayout) else { return true }
    if let setLayout = selfLayout as? SetViewLayout {
        return setLayout.subLayouts.reduce(true) { previous, currentLayout in
            previous && hasAllSubFrame(currentLayout)
        }
    } else {
        return hasSelfFrame(selfLayout)
    }
}

// Has at least one Visible View
func isVisibledLayout(_ selfLayout: LayoutAttribute) -> Bool {
    if let setViewLayout = selfLayout as? SetViewLayout {
        var hasVisibleViewLayout = false
        setViewLayout.subLayouts.forEach { (attribute) in
            guard let viewLayout = attribute as? ViewLayout else { return }
            // Make sure layoutAttribute is not Spacer
            hasVisibleViewLayout = hasVisibleViewLayout || isVisibledLayout(viewLayout)
        }
        return hasVisibleViewLayout
    } else if let viewLayout = selfLayout as? ViewLayout {
        // view == nil --> INVISIBLE
        // has View + Hidden --> INVISIBLE
        // has View + Visible --> VISIBLE
        return viewLayout.view?.isVisible == true
    } else {
        // VSpace, HSpacer
        return false
    }
}
