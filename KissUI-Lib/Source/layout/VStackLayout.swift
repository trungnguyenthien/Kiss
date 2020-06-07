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
    
    
    public override func makeSizeSubviews(width: Double) {
         traceClassName(self, message: "layoutSubviews")
         let contentWidth = width - paddingLeft - paddingRight
         subLayouts.forEach {
             let layoutSubviewsAble = $0 as? LayoutAttribute
             switch $0.widthDesignValue {
             case .value(let evalue):
                layoutSubviewsAble?.makeSizeSubviews(width: evalue)
             case .fillRemain(_):
                layoutSubviewsAble?.makeSizeSubviews(width: contentWidth)
             case .none:
                ()
            }
             
             if $0.expectedHeight == nil {
                 switch $0.heightDesignValue {
                 case .equalWidth(let hew):
                     guard let ewidth = $0.expectedWidth else { return }
                     $0.expectedHeight = ewidth * hew
                     
                 case .value(let value):
                     $0.expectedHeight = value
                     
                 case .fillRemain(_), .fit:
                     layoutSubviewsAble?.layoutSubviews(width: contentWidth)
                     if let setViewLayout = $0 as? SetViewLayout {
                         let expectedHeight = setViewLayout.subLayouts.last?.expectedHeight ?? 0
                         let y = setViewLayout.subLayouts.last?.expectedY ?? 0
                         $0.expectedHeight = y + expectedHeight + $0.paddingTop + $0.paddingBottom
                     }
                 case .none:
                    ()
                }
             }

         }
     }
     
    public override func layoutSubviews(width: Double) {
        makeSizeSubviews(width: width)
        traceClassName(self, message: "layoutSubviews")
        subLayouts.forEach { $0.layoutSubviews(width: $0.expectedWidth ?? 0) }
     }
}
