
import Foundation
import UIKit

enum DevWidthValue {
    case value(Double)
    case grow(Double) // full = grow(9999999999999)
    case fit
}

enum DevHeightValue {
    case value(Double)
    case fit
    case whRatio(Double)
    case grow(Double)
}


enum DevMaxHeightValue {
    case none
    case value(Double)
    case full
    case fit
}

// -------------

public enum WidthValue {
    case fit
    case full
    case grow(Double)
}

public enum HeightValue {
    case fit
    case full
    case whRatio(Double) // height / width
}

public enum MaxHeightValue {
    case none
    case fit
    case full
}


public protocol SizeSetter {
    @discardableResult func width(_ value: Double) -> Self
    @discardableResult func width(_ value: WidthValue) -> Self
    
    @discardableResult func height(_ value: Double) -> Self
    @discardableResult func height(_ value: HeightValue) -> Self
    
    @discardableResult func size(_ value: CGSize) -> Self
    @discardableResult func size(_ width: Double, _ height: Double?) -> Self
    
    @discardableResult func maxHeight(_ value: Double) -> Self
}

extension SizeSetter where Self: LayoutItem {
    public func size(_ value: CGSize) -> Self {
        attr.userWidth = .value(Double(value.width))
        attr.userHeight = .value(Double(value.height))
        return self
    }
    
    public func size(_ width: Double, _ height: Double?) -> Self {
        attr.userWidth = .value(Double(width))
        if let height = height {
            attr.userHeight = .value(Double(height))
        } else {
            attr.userHeight = .fit
        }
        return self
    }
    
    public func width(_ value: Double) -> Self {
        attr.userWidth = .value(Double(value))
        return self
    }
    
    public func width(_ value: WidthValue) -> Self {
        switch value {
        case .grow(let fill): attr.userWidth = .grow(fill)
        case .full: attr.userWidth = .grow(.max)
        case .fit: attr.userWidth = .fit
        }
        return self
    }
    
    public func height(_ value: Double) -> Self {
        attr.userHeight = .value(Double(value))
        return self
    }
    
    public func height(_ value: HeightValue) -> Self {
        switch value {
        case .fit: attr.userHeight = .fit
        case .full: attr.userHeight = .grow(.max)
        case .whRatio(let ew): attr.userHeight = .whRatio(ew)
        }
        return self
    }

    public func maxHeight(_ value: Double) -> Self {
        attr.userMaxHeight = value
        return self
    }
}
