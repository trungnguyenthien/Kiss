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
    func arrangeItems()
}

public func render(group: GroupLayout, forRoot view: UIView) {
    let copy = group.copy() as! GroupLayout
    copy.attr.expectedX = view.x
    copy.attr.expectedY = view.y
    
    switch copy.attr.widthDesignValue {
    case .grow(let part) where part == .max: copy.attr.expectedWidth = view.width
    case .grow: throwError("Root View không thể set width(.grow)")
    case .value(let width): copy.attr.expectedWidth = width
    case .autoFit: throwError("Root View không thể set width(.autoFit)")
    }
    
    switch copy.attr.heightDesignValue {
    case .grow(let part) where part == .max: copy.attr.expectedHeight = view.height
    case .grow: throwError("Root View không thể set height(.grow)")
    case .whRatio: throwError("Root View không thể set height(.whRatio)")
    case .autoFit: ()
    case .value(let height): copy.attr.expectedHeight = height
    }
    
    group.arrangeAble?.arrangeItems()
}

private func _render(group: GroupLayout) {
    add_spacer_To_SelfLayout_For_AutoAlignment(group: group)
    _3_apply_FixWidth_For_SubLayout(viewLayout: group)
    _4_apply_GrowWidth_For_SubLayout_And_Spacer(viewLayout: group)
    _5_apply_FixHeight_To_SubLayout(viewLayout: group)
    _7_apply_GrowHeight_To_SubLayout(viewLayout: group)
    _8_apply_Frame_To_SubLayout(viewLayout: group)
    _9_apply_SelfHeight(viewLayout: group)
    _10_reCheck(viewLayout: group)
}

func add_spacer_To_SelfLayout_For_AutoAlignment(group: GroupLayout) {
    switch group.attr.horizontalAlignment {
    case .left: group.layoutItems.insert(spacer, at: 0)
    case .right: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    switch group.attr.verticalAlignment {
    case .top: group.layoutItems.insert(spacer, at: 0)
    case .bottom: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    group.fullOptimize()
}

func _3_apply_FixWidth_For_SubLayout(viewLayout: GroupLayout) {
    guard let group = viewLayout as? GroupLayout else { return }
    group.layoutItems.forEach {
        switch $0.widthDesignValue {
        case .value(let size): $0.attr.expectedWidth = size
        case .grow(_): ()
        case .autoFit: ()
        }
    }
}

//private func _4_applyFitWidthForSubLayout() {
//
//}

func _4_apply_GrowWidth_For_SubLayout_And_Spacer(viewLayout: GroupLayout) {

    // HSTACK ONLY
    if let hstack = viewLayout as? HStackLayout {
        var remainWidth = viewLayout.attr.expectedWidth ?? 0
        remainWidth -= viewLayout.attr.paddingLeft
        remainWidth -= viewLayout.attr.paddingRight
        var sumPart = 0.0
        hstack.layoutItems.forEach {
            remainWidth -= $0.expectedWidth ?? 0
            switch $0.widthDesignValue {
            case .grow(let part): sumPart += part
            default: ()
            }
        }
        
        hstack.layoutItems.forEach {
            switch $0.widthDesignValue {
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
        vstack.layoutItems.forEach {
            switch $0.widthDesignValue {
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
    
}

func _5_apply_FixHeight_To_SubLayout(viewLayout: GroupLayout) {
    guard let setLayout = viewLayout as? GroupLayout else { return }
    setLayout.layoutItems.forEach {
        switch $0.heightDesignValue {
        case .value(let size):
            $0.attr.expectedHeight = size
        case .whRatio(let ratio):
            guard let eWidth = $0.expectedWidth else {
                throwError("Khi sử dụng height(.widthPerHeightRatio), thì width phải là .value/.grow/.autoFit (nếu là Label)")
                return
            }
            $0.attr.expectedHeight = eWidth / ratio
        case .autoFit: ()
        case .grow(_): ()
        }
    }
}

private func reUpdateExpectedHeightByMinHeight(_ lItem: LayoutItem) {
    guard let height = lItem.expectedHeight, let minHeight = lItem.minHeight else { return }
    lItem.attr.expectedHeight = max(height, minHeight)
}

func _7_apply_GrowHeight_To_SubLayout(viewLayout: GroupLayout) {
    
    if let vstack = viewLayout as? VStackLayout {
        var remainHeight = 0.0
        remainHeight -= vstack.attr.paddingBottom
        remainHeight -= vstack.attr.paddingTop
        let visibleLayout = vstack.layoutItems.filter { !isSpacer($0) }
        visibleLayout.enumerated().forEach { (index, layout) in
            let startIndex = 0
            let endIndex = visibleLayout.count - 1
                
            if index > startIndex { remainHeight -= layout.top }
            remainHeight -= layout.expectedHeight ?? 0.0
            if index < endIndex { remainHeight -= layout.bottom }
        }
        var sumPart = 0.0
        vstack.layoutItems.filter { isSpacer($0) }.forEach {
            switch $0.heightDesignValue {
            case .grow(let part):
                sumPart += part
                
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
        }
        
        vstack.layoutItems.filter { isSpacer($0) }.forEach {
            switch $0.heightDesignValue {
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
        let visibleLayout = hstack.layoutItems.filter { !isSpacer($0) }
        visibleLayout.forEach {
            switch $0.heightDesignValue {
            case .grow(_):
                printWarning("Khi sử dụng height(.grow) trong HStack sẽ tự ép về height(.full)")
                $0.attr.heightDesignValue = .grow(.max)
            
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
            maxHeight = max(maxHeight, $0.expectedHeight ?? 0.0)
        }
        
        visibleLayout.forEach {
            switch $0.heightDesignValue {
            case .grow(_):
                $0.attr.expectedHeight = maxHeight
            
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
            
        }
    }

    
    if let wrap = viewLayout as? WrapLayout {
        let visibleLayout = wrap.layoutItems.filter { !isSpacer($0) }
        visibleLayout.forEach {
            switch $0.heightDesignValue {
            case .grow(_): throwError("Trong Wrap không sử dụng width(.grow), width(.full), height(.grow), height(.full)")
            case .value(_): ()
            case .autoFit: ()
            case .whRatio(_): ()
            }
        }
    }
}

private func _8_apply_Frame_To_SubLayout(viewLayout: GroupLayout) {
    
}

private func _9_apply_SelfHeight(viewLayout: GroupLayout) {
    
}

func _10_reCheck(viewLayout: GroupLayout) -> Bool {
    return false
}

/// ----------------------------------------------------------------------


func fitSizeSetLayout(of lItem: LayoutItem) -> CGSize? {
    
    if let group = lItem as? GroupLayout {
        var minX = Double.max
        var minY = Double.max
        var maxX = Double.min
        var maxY = Double.min
        
        group.layoutItems.forEach { (attr) in
            guard !isSpacer(attr) else { return }
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
        return CGSize(width: maxX - minX + lItem.paddingLeft + lItem.paddingRight,
                      height: maxY - minY + lItem.paddingBottom + lItem.paddingTop)
    }
    
    return .zero
}

func transitFrame(viewLayout: UIViewLayout, newX: Double, newY: Double) {
    if viewLayout.attr.expectedX == nil {
        viewLayout.attr.expectedX = newX
    }
    
    if viewLayout.attr.expectedY == nil {
        viewLayout.attr.expectedY = newY
    }
    
    guard let group = viewLayout as? GroupLayout else { return }
    let dx = newX - (viewLayout.attr.expectedX ?? 0)
    let dy = newY - (viewLayout.attr.expectedY ?? 0)
    
    group.layoutItems.forEach { (subLayout) in
        var newX = subLayout.expectedX ?? 0
        if let currentX = subLayout.expectedX {
            newX = currentX + dx
        }
        var newY = subLayout.expectedY ?? 0
        if let currentY = subLayout.expectedY {
            newY = currentY + dy
        }
        
        if let layout = subLayout as? UIViewLayout {
            transitFrame(viewLayout: layout, newX: newX, newY: newY)
        }
    }
}

private func isSpacer(_ lItem: LayoutItem) -> Bool {
    return lItem is Spacer
}

private func isLabelLayout(attr: UIViewLayout) -> Bool {
    return attr.view is UILabel
}

private func hasSelfSize(_ selfLayout: LayoutAttribute) -> Bool {
    if selfLayout is Spacer { return true }
    return selfLayout.expectedWidth != nil && selfLayout.expectedHeight != nil
}

private func hasSelfFrame(_ lItem: LayoutItem) -> Bool {
    if lItem is Spacer { return true }
    return lItem.expectedWidth.notNil &&
        lItem.expectedHeight.notNil &&
        lItem.expectedX.notNil &&
        lItem.expectedY.notNil
}

func hasAllSubFrame(_ lItem: LayoutItem) -> Bool {
    if let setLayout = lItem as? GroupLayout {
        return setLayout.layoutItems.reduce(true) { previous, currentLayout in
            previous && hasAllSubFrame(currentLayout)
        }
    } else {
        return hasSelfFrame(lItem)
    }
}

func removeInvisibleItem(item: LayoutItem) -> Bool {
    if let group = item as? GroupLayout {
        
    }
    return false
}
