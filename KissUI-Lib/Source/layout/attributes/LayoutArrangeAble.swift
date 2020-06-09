//
//  LayoutArrangeAble.swift
//  KissUI
//
//  Created by Trung on 6/9/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

protocol LayoutArrangeAble {
    func startLayout()
    func applySelfHardSize()
    func applySubsWidth()
    func applySubsHeight()
    func applySubsFrame()
    func applySelfHeight()
    func applySubSpacers()
    func applySubsAlignments()
}

extension LayoutArrangeAble {
    func applySelfHardSize() {
        guard let attr = self as? LayoutAttribute else { return }
        switch attr.widthDesignValue {
        case .value(let width):
            attr.expectedWidth = width
        default: ()
        }
        
        switch attr.heightDesignValue {
        case .value(let height):
            attr.expectedHeight = height
        default: ()
        }
    }
    
    func startLayout() {
        /*
          2.applySubsWidth
          3.sub.startLayout
          4.applySubsHeight
          5.applySubsFrame
          5.1.applySelfHardSize
          6.applySelfHeight
          7.applySubSpacers
          8.applySubsAlignments
         */
        
        applySubsWidth()
        if let setLayout = self as? SetViewLayout {
            let subLayoutAbles = setLayout.subLayouts.compactMap { $0 as? LayoutArrangeAble }
            subLayoutAbles.forEach { $0.startLayout() }
        }
        applySubsHeight()
        applySubsFrame()
        applySelfHardSize()
        applySelfHeight()
        applySubSpacers()
        applySubsAlignments()
    }
}
