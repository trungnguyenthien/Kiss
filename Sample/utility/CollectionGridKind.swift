//
//  CollectionGridKind.swift
//  Sample
//
//  Created by Trung on 7/17/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

var isPortrait: Bool {
    return UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown
}

var isLanscape: Bool {
    return !isPortrait
}

enum CollectionGridKind {
    case phonePortrait, phoneLandscape, padPortrait, padLandscape
    
    init() {
        if isPad && isPortrait {
            self = isPortrait ? .padPortrait : .padLandscape
        } else {
            self = isPortrait ? .phonePortrait : .phoneLandscape
        }
    }
    
    var columns: Int {
        switch self {
        case .phonePortrait: return 2
        case .phoneLandscape: return 2
            
        case .padPortrait: return 4
        case .padLandscape: return 2
        }
    }
    
    var isVerticalCell: Bool {
        switch self {
        case .phonePortrait:  return true
        case .padPortrait:    return true

        case .phoneLandscape: return false
        case .padLandscape:   return false
        }
    }
    
    var cellWidth: CGFloat {
        return ((UIScreen.main.bounds.width) / CGFloat(columns)) - 1
    }
}
