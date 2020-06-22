//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VStackLayout: GroupLayout {
    override init() {
        super.init()
        self.attr.userWidth = .grow(.max)
        self.attr.userHeight = .fit
        self.attr.userMaxHeight = .none
    }
}

extension VStackLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let instance = VStackLayout()
        instance.layoutItems = self.layoutItems.copy(with: zone)
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups.copy()
        return instance
    }
}

extension VStackLayout: LayoutArrangeAble {
    func arrangeItems(draft: Bool) {
        addSpacerForAlignment(group: self) // For vertical alignment
        removeStartEndPadding()
        removePaddingIfHasSpacer()
        makeItemsWidth() //
        arrangeAbleItems.forEach { $0.arrangeItems(draft: true) } // Dựa vào width đã xác định trước, arrangeItems cho
        makeItemsHeight()
        makeItemXY()
    }
    
    private func removeStartEndPadding() {
        let noSpacerLayoutItems = layoutItems.filter { !$0.isSpacer }
        noSpacerLayoutItems.first?.attr.devTop = 0
        noSpacerLayoutItems.last?.attr.devBottom = 0
    }
        
    private func removePaddingIfHasSpacer() {
        layoutItems.enumerated().forEach { (index, item) in
            guard item is Spacer else { return }
            layoutItems.element(index - 1)?.attr.devBottom = 0
            layoutItems.element(index + 1)?.attr.devTop = 0
        }
    }
    
    func makeItemXY() {
        var runY = 0.0
        runY += attr.userPaddingTop
        layoutItems.forEach {
            let myWidth = $0.attr.devWidth ?? 0
            let myHeight = $0.attr.devHeight ?? 0
            $0.attr.devY = runY
            runY += myHeight
            let remainSpaceX = (attr.devWidth ?? 0) - myWidth - attr.userPaddingLeft - attr.userPaddingRight
            switch $0.attr.userHorizontalAlign {
                
            case .left:     $0.attr.devX = attr.userPaddingRight
            case .right:    $0.attr.devX = attr.userPaddingRight + remainSpaceX
            case .center:   $0.attr.devX = attr.userPaddingRight + remainSpaceX / 2
            }
        }
    }
    
    private func makeItemsHeight() {
        var remainHeight = attr.devHeight ?? 0
        remainHeight -= attr.userPaddingTop
        remainHeight -= attr.userPaddingBottom
        var sumPart = 0.0
        layoutItems.forEach {
            switch $0.attr.userHeight {
            case .value(let fixHeight):
                $0.attr.devHeight = fixHeight
                remainHeight -= $0.attr.devHeight ?? 0
                
            case .fit:
                $0.attr.devHeight = autofitHeight(item: $0)
                remainHeight -= $0.attr.devHeight ?? 0
                
            case .whRatio where $0.attr.devWidth.isNil:
                throwError("Thuộc tính height(.ratio) không khả dụng nếu width không thể xác định")
                
            case .whRatio(let ratio):
                let myWidth = $0.attr.devWidth ?? 0
                $0.attr.devHeight = myWidth / ratio
                remainHeight -= $0.attr.devHeight ?? 0
                
            case .grow(let part):
                sumPart += part
            }
        }
        
        layoutItems.forEach {
            switch $0.attr.userHeight {
            case .value, .fit,.whRatio: break
            case .grow(let part):
                $0.attr.devHeight = remainHeight * part / sumPart
            }
        }
        
    }
    
    private func makeItemsWidth() {
        var remainWidth = attr.devWidth ?? 0
        remainWidth -= attr.userPaddingLeft
        remainWidth -= attr.userPaddingRight
        
        layoutItems.forEach {
            switch $0.attr.userWidth {
            case .value(let fix):
                $0.attr.devWidth = fix
                
            case .grow(let part):
                if part != .max { printWarning("Thuộc tính width(.grow) trong VStack không khả dụng, sẽ đưa về width(.full)") }
                $0.attr.userWidth = .grow(.max)
                $0.attr.devWidth = remainWidth
                
            case .fit where $0 is GroupLayout:
                guard let group = $0 as? GroupLayout else { return }
                guard group.attr.devWidth == nil else { return }
                group.arrangeAble?.arrangeItems(draft: true)
                group.attr.devWidth = autofitWidth(item: group)
                
            case .fit:
                guard let viewLayout = $0 as? UIViewLayout else { return }
                viewLayout.view?.applyFitSize(attr: viewLayout.attr)
                $0.attr.devWidth = viewLayout.view?.width ?? 0
                $0.attr.devHeight = viewLayout.view?.height ?? 0
            }
        }
    }
}
