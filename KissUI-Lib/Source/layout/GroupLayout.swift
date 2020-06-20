//
//  GroupLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class GroupLayout: ViewLayout, AlignmentSetter {
    var subItems = [LayoutItem]()
}

extension GroupLayout {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let clone = GroupLayout()
        clone.view = self.view
        clone.subItems = self.subItems.copy(with: zone)
        clone.attr = self.attr.copy(with: zone) as! LayoutAttribute
        return clone
    }
}
