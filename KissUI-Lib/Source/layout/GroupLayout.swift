//
//  GroupLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol GroupLayoutSetter: PaddingSetter, MarginSetter, SizeSetter, AlignmentSetter, SelfAlignSetter {}

public class GroupLayout: LayoutItem, GroupLayoutSetter {
    var baseView: UIView? = nil
    var body = makeBlankView()
    var layoutItems = [LayoutItem]()
    var attr = LayoutAttribute()
    var overlayGroups = [GroupLayout]()
    
    public var layerViews: [UIView] {
        var views: [UIView] = []
        views.append(body)
        views.append(contentsOf: overlayGroups.map { $0.body })
        return views
    }
    
    func insert(view: UIViewLayout, at index: Int) {
        body.insertSubview(view.root, at: index)
        body.yoga.markDirty()
    }
    
    func autoMarkIncludedInLayout() {
        layoutItems.forEach {
            if let uiviewLayout = $0 as? UIViewLayout {
                uiviewLayout.root.yoga.isIncludedInLayout = uiviewLayout.isVisible
            }
            if let group = $0 as? GroupLayout {
                group.autoMarkIncludedInLayout()
            }
        }
    }
    
    func autoMarkDirty() {
        layoutItems.forEach {
            if let group = $0 as? GroupLayout {
                group.autoMarkDirty()
            }
            
            if let uiviewLayout = $0 as? UIViewLayout {
                let view = uiviewLayout.root
                if view is UILabel ||
                   view is UIButton ||
                   view is UITextView ||
                   view is UIImageView ||
                   view is UITextField {
                    view.yoga.markDirty()
                }
            }

        }
    }
    
    func resetMargin() {
        layoutItems.forEach {
            $0.attr.mLeft = $0.attr.userMarginLeft
            $0.attr.mRight = $0.attr.userMarginRight
            $0.attr.mTop = $0.attr.userMarginTop
            $0.attr.mBottom = $0.attr.userMarginBottom
        }
    }
    
    func overlay(@GroupLayoutBuilder builder: () -> [GroupLayout]) -> Self {
        overlayGroups.append(contentsOf: builder())
        return self
    }
    
    public var isVisible: Bool {
        return hasVisibleView
    }
    
    var arrangeAble: FlexLayoutItemProtocol? {
        return self as? FlexLayoutItemProtocol
    }
    
    var arrangeAbleItems: [FlexLayoutItemProtocol] {
        return layoutItems.compactMap { $0 as? FlexLayoutItemProtocol }
    }
    
    func fullOptimize() {
        selfOptimize()
        layoutItems
            .compactMap { $0 as? GroupLayout }
            .forEach { $0.selfOptimize() }
    }
    
    private func selfOptimize() {
        removeInvisibleItem()
        reduceSpacer()
    }
    
    private func removeInvisibleItem() {
        layoutItems.removeAll { !$0.isVisible }
    }
    
    /*
     Loại bỏ trường hợp 2 hay nhiều spacer liên tục nhau thành 1 spacer
     */
    private func reduceSpacer() {
        var secondarySpacer = [Spacer]()
        layoutItems.enumerated().forEach { (index, item) in
            if index == 0 { return }
            let previousItem = layoutItems[index - 1]
            guard let spacer = layoutItems[index] as? Spacer, previousItem is Spacer else { return }
            secondarySpacer.append(spacer)
        }
        
        layoutItems.removeAll { (layoutItem) -> Bool in
            let spacer = layoutItem as? Spacer
            return secondarySpacer.contains { spacer === $0 }
        }
    }
}

extension GroupLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let newInstance = GroupLayout()
        newInstance.layoutItems = self.layoutItems.copy(with: zone)
        newInstance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        newInstance.overlayGroups = self.overlayGroups.copy()
        return newInstance
    }
}

extension GroupLayout {
    var views: [UIView] {
        var output = [UIView]()
        layoutItems.forEach {
            if let group = $0 as? GroupLayout {
                // Recursive to get all views
                output.append(contentsOf: group.views)
            } else if let uiviewLayout = $0 as? UIViewLayout {
                output.append(uiviewLayout.root)
            }
        }
        return output
    }
    
    var visibleViews: [UIView] {
        return views.filter { $0.isVisible }
    }
    
    var hasVisibleView: Bool {
        return !visibleViews.isEmpty
    }
}

extension GroupLayout {
    /// Remove Subview hiện tại, construct lại hệ thống view mới
    public func constructLayout() {
        let flex = self as? FlexLayoutItemProtocol
        flex?.configureLayout()
    }
    
    /// Layout lại vị trí view mới, những view bị hidden sẽ remove khỏi hệ thống layout.
    /// Nên gọi phương thức này sau khi set nội dung view và set hidden view hoàn tất.
    /// - Parameters:
    ///   - width: nil -> autoFit Width
    ///   - height: nil -> autoFit Height
    public func updateLayoutChange(width: CGFloat? = nil, height: CGFloat? = nil) {
        let flex = self as? FlexLayoutItemProtocol
        flex?.layoutRendering()
        body.applyLayout(preservingOrigin: true, fixWidth: width, fixHeight: height)
        constructLayout()
    }
    
    /// Tính toán size cần thiết để render layout
    /// - Parameters:
    ///   - width: nil nếu muốn fit chiều dài
    ///   - height: nil nếu muốn fit chiều cao
    /// - Returns: size cần thiết để render layout
    public func estimatedSize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        let flex = self as? FlexLayoutItemProtocol
        flex?.layoutRendering()
        let fixWidth = width ?? .nan
        let fixHeight = height ?? .nan
        return body.yoga.calculateLayout(with: CGSize(width: fixWidth, height: fixHeight))
    }
}
