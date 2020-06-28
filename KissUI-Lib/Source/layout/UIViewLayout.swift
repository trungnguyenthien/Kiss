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
protocol UIViewLayoutSetter: PaddingSetter, MarginSetter, SizeSetter { }

public class UIViewLayout: LayoutItem, UIViewLayoutSetter {
    var attr = LayoutAttribute()
    var body = makeBlankView()
    var overlayGroups = [GroupLayout]()
    init() {
        self.attr.userWidth = .fit
        self.attr.userHeight = .fit
    }
    
    public var isVisible: Bool {
        return body.isVisible == true
    }
    
    var labelContent: UILabel? {
        return body as? UILabel
    }
    
    public func alignSelf(_ value: CrossAxisAlignment) -> Self {
        attr.alignSelf = value
        return self
    }
    
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

extension UIViewLayout: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let instance = UIViewLayout()
        instance.body = self.body
        instance.attr = self.attr.copy(with: zone) as! LayoutAttribute
        return instance
    }
}

extension UIViewLayout: FlexLayoutItemProtocol {
    func layoutRendering() {
        
    }
    
    func configureLayout() {
        body.configureLayout { (l) in
            l.isEnabled = true
            self.attr.map(to: l)
        }
    }
}
