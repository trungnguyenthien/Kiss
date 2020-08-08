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
    case phonePortrait(CGFloat)
    case phoneLandscape(CGFloat)
    case padPortrait(CGFloat)
    case padLandscape(CGFloat)
    
    init(width: CGFloat, height: CGFloat) {
        let isPortrait = width < height
        if isPad && isPortrait {
            self = isPortrait ? .padPortrait(width) : .padLandscape(width)
        } else {
            self = isPortrait ? .phonePortrait(width) : .phoneLandscape(width)
        }
    }
    
    init() {
        let width = UIScreen.main.bounds.width
        if isPad && isPortrait {
            self = isPortrait ? .padPortrait(width) : .padLandscape(width)
        } else {
            self = isPortrait ? .phonePortrait(width) : .phoneLandscape(width)
        }
    }
    
    var columns: Int {
        switch self {
        case .phonePortrait: return 2
        case .phoneLandscape: return 2
            
        case .padPortrait: return 4
        case .padLandscape: return 3
        }
    }
    
    
    var width: CGFloat {
        switch self {
        case let .padLandscape(width),
             let .padPortrait(width),
             let .phonePortrait(width),
             let .phoneLandscape(width):
            return width
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
        return (width / CGFloat(columns)) - 1
    }
}
