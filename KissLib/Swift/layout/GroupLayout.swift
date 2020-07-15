//
//  GroupLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public enum AutoInvisibility {
    case never
    case allInvisible
}

protocol GroupLayoutSetter: PaddingSetter, MarginSetter, SizeSetter, AlignmentSetter, SelfAlignSetter {}

public class GroupLayout: UIViewLayout, GroupLayoutSetter {
    var baseView: UIView?
    var layoutItems = [LayoutItem]()
    var autoInvisibility = AutoInvisibility.allInvisible

    public var layerViews: [UIView] {
        var views: [UIView] = []
        views.append(body)
        allOverlayGroup.forEach {
            views.append($0.body)
        }
        return views
    }

    public func autoInvisible(_ type: AutoInvisibility) -> Self {
        autoInvisibility = type
        return self
    }

    func insert(view: UIViewLayout, at index: Int) {
        body.insertSubview(view.body, at: index)
        body.yoga.markDirty()
    }

    func resetForcedValue() {
        layoutItems.forEach {
            $0.attr.forcedLeft = $0.attr.userMarginLeft
            $0.attr.forcedRight = $0.attr.userMarginRight
            $0.attr.forcedTop = $0.attr.userMarginTop
            $0.attr.forcedBottom = $0.attr.userMarginBottom
            $0.attr.forcedWidth = nil
            $0.attr.forcedHeight = nil
        }
    }

    public override var isVisibleLayout: Bool {
        if body.isHidden { return false }

        switch autoInvisibility {
        case .never: return true
        case .allInvisible: return hasVisibleView
        }
    }

    /*
     Loại bỏ trường hợp 2 hay nhiều spacer liên tục nhau thành 1 spacer
     */
    private func reduceSpacer() {
        var secondarySpacer = [Spacer]()
        layoutItems.enumerated().forEach { index, _ in
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

extension GroupLayout {
    /// Chỉ xét những view đóng vai trò là content, như uilabel, uibutton, image,...
    var uiContentViews: [UIView] {
        var output = [UIView]()
        layoutItems.forEach {
            if let group = $0 as? GroupLayout {
                // Recursive to get all views
                output.append(contentsOf: group.uiContentViews)
            } else if let uiviewLayout = $0 as? UIViewLayout {
                output.append(uiviewLayout.body)
            }
        }
        return output
    }

    var hasVisibleView: Bool {
        let visibleViews = layoutItems.filter { $0.isVisibleLayout }
        return !visibleViews.isEmpty
    }
}

extension GroupLayout {
    var allOverlayGroup: [GroupLayout] {
        var groups = [GroupLayout]()
        groups.append(contentsOf: overlayGroups)

        layoutItems.forEach { layoutItem in
            if let viewLayout = layoutItem as? UIViewLayout {
                groups.append(contentsOf: viewLayout.overlayGroups)
            }
            if let groupLayout = layoutItem as? GroupLayout {
                groups.append(contentsOf: groupLayout.allOverlayGroup)
            }
        }

        return groups
    }

    func resetViewHierachy() {
        body.resetYoga()
        body.removeFromSuperview()
        layoutItems.forEach {
            $0.root.resetYoga()
            $0.root.removeFromSuperview()
            guard let group = $0 as? GroupLayout else { return }
            group.resetViewHierachy()
        }
        allOverlayGroup.forEach {
            $0.body.removeFromSuperview()
            $0.resetViewHierachy()
        }
    }

    /// Remove Subview hiện tại, construct lại hệ thống view mới
    func constructLayout() {
        let flex = self
        flex.prepareForRenderingLayout()
        flex.configureLayout()
    }

    /// Layout lại vị trí view mới, những view bị hidden sẽ remove khỏi hệ thống layout.
    /// Nên gọi phương thức này sau khi set nội dung view và set hidden view hoàn tất.
    /// - Parameters:
    ///   - width: nil -> autoFit Width
    ///   - height: nil -> autoFit Height
    func updateLayoutChange(width: CGFloat? = nil, height: CGFloat? = nil) {
        constructLayout()

        body.applyLayout(preservingOrigin: false, fixWidth: width, fixHeight: height)

        allOverlayGroup.forEach { overlay in
            guard let base = overlay.baseView else { return }
            overlay.overlayUpdateLayout(width: base.bounds.width, height: base.bounds.height)
//            guard let superView = overlay.root.superview else { return }
//            guard let newFrame = superView.convertedFrame(subview: base) else {  return }
//            overlay.root.frame = newFrame
        }
    }

    private func overlayUpdateLayout(width: CGFloat, height: CGFloat) {
        constructLayout()
        body.applyLayout(preservingOrigin: false, fixWidth: width, fixHeight: height)
        guard let superView = root.superview else { return }
        guard let base = baseView else { return }
        guard let newFrame = superView.convertedFrame(subview: base) else { return }
        root.frame = newFrame
    }

    /// Tính toán size cần thiết để render layout
    /// - Parameters:
    ///   - width: nil nếu muốn fit chiều dài
    ///   - height: nil nếu muốn fit chiều cao
    /// - Returns: size cần thiết để render layout
    func estimatedSize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        constructLayout()
        let fixWidth = width ?? .nan
        let fixHeight = height ?? .nan
        return body.yoga.calculateLayout(with: CGSize(width: fixWidth, height: fixHeight))
    }
}
