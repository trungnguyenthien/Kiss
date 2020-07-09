//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

protocol UIViewLayoutSetter: LayoutItem, PaddingSetter, MarginSetter, SizeSetter, FlexLayoutItemProtocol, NSCopying { }

public class UIViewLayout: UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var body = makeBlankView()
    var overlayGroups = [GroupLayout]()
    
    init() {
        self.attr.maxHeight = .none
        self.attr.alignSelf = .stretch
    }
    
    public func crossAlign(self value: CrossAxisAlignment) -> Self {
        attr.alignSelf = value
        return self
    }
    
    func prepareForRenderingLayout() {
        /// Hiện tại library đang có issue: nếu chèn 1 custom view vào thì không tự tính size được
        /// Có 2 cách fix:
        /// 1 - mở đoạn code đc comment dưới đây, nhưng performance thấp --> Không sử dụng
        /// 2 - custom view layout phải được cố định main-size
        
//        if let customViewLayout = body.kiss.currentGroupLayout {
//            body.frame.size = customViewLayout.estimatedSize()
//        }
    }
    
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            l.isIncludedInLayout = self.isVisibleLayout
            l.markDirty()
            self.attr.map(to: l)
        }
    }
    public var isVisibleLayout: Bool {
        return body.isVisible
    }
    
    public var cloned: Self {
        let newInstance = copy()
        if let newInstance = newInstance as? UIViewLayout {
            newInstance.body = body
        }
        return newInstance  as! Self
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = UIViewLayout()
        instance.body = self.body
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        instance.overlayGroups = self.overlayGroups
        return instance
    }
}

//MARK: - layout builder function
extension UIViewLayout {
    public func overlay(@GroupLayoutBuilder builder: () -> [GroupLayout]) -> Self {
        let groups = builder()
        groups.forEach { $0.baseView = self.body }
        overlayGroups.append(contentsOf: groups)
        return self
    }
    
    public func overlay(@GroupLayoutBuilder builder: () -> GroupLayout) -> Self {
        let group = builder()
        group.baseView = self.body
        overlayGroups.append(group)
        return self
    }
}
