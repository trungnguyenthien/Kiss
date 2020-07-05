//
//  ViewLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

protocol UIViewLayoutSetter: LayoutItem, PaddingSetter, MarginSetter, SizeSetter, FlexLayoutItemProtocol, NSCopying { }

public class UIViewLayout: UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var body = makeBlankView()
    var overlayGroups = [GroupLayout]()
    
    init() {
        self.attr.maxHeight = .none
        self.attr.alignSelf = .stretch
    }
    
    public func alignSelf(_ value: CrossAxisAlignment) -> Self {
        attr.alignSelf = value
        return self
    }
    
    func layoutRendering() {
        
    }
    
    func configureLayout() {
        print("Self Type = \(self.body.classForCoder)")
        body.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
        }
    }
    
    public var isVisible: Bool {
        return body.isVisible == true
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
