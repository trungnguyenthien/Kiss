//
//  SetViewLayout.swift
//  KissUI
//
//  Created by Trung on 5/28/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

public protocol LayoutItem { }

public class SetViewLayout: ViewLayout, AlignmentSetter {
    var subItems = [LayoutItem]()
}
