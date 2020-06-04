//
//  VStackLayout.swift
//  KissUI
//
//  Created by Trung on 6/4/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation


public class VStackLayout: SetViewLayout {
    override init() {
        super.init()
        self.isControl = false
    }
}

extension LayoutSubviewsAble where Self: VStackLayout {
    public func makeSizeSubviews(width: Double) {
        
        let contentWidth = width - paddingLeft - paddingRight
        subLayouts.forEach {
            let layoutSubviewsAble = $0 as? LayoutSubviewsAble
            switch $0.widthValue {
            case .value(let evalue): layoutSubviewsAble?.makeSizeSubviews(width: evalue)
            case .fill(_): layoutSubviewsAble?.makeSizeSubviews(width: contentWidth)
            }
            
            if $0.expectedHeight == nil {
                switch $0.heightValue {
                case .equalWidth(let hew):
                    guard let ewidth = $0.expectedWidth else { return }
                    $0.expectedHeight = ewidth * hew
                    
                case .value(let value):
                    $0.expectedHeight = value
                    
                case .fill(_):
                    fatalError("Content trong StackLayout thì không height=.fill")
                    
                case .fit:
                    layoutSubviewsAble?.layoutSubviews(width: contentWidth)
                    if let setViewLayout = $0 as? SetViewLayout {
                        let expectedHeight = setViewLayout.subLayouts.last?.expectedHeight ?? 0
                        let y = setViewLayout.subLayouts.last?.expectedY ?? 0
                        $0.expectedHeight = y + expectedHeight + $0.paddingTop + $0.paddingBottom
                    }
                }
            }

        }
    }
    
    public func layoutSubviews(width: Double) {
        makeSizeSubviews(width: width)
        
    }
}
