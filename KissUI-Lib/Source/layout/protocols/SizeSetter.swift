
import Foundation
import UIKit

public enum DevWidthValue {
    case value(Double)
    case grow(Double) // full = grow(9999999999999)
    case autoFit
}

public enum DevHeightValue {
    case value(Double)
    case autoFit
    case whRatio(Double)
    case grow(Double)
}


public enum DevMaxHeightValue {
    case none
    case value(Double)
    case infinite
    case fit
}

//

public enum WidthValue {
    case grow(Double)
    case full
}

public enum HeightValue {
    case autoFit
    case full
    // height / width
    case widthPerHeightRatio(Double)
    case grow(Double)
}

public enum MaxHeightValue {
    case none
    case fit
    case infinite
}


public protocol SizeSetter {
    @discardableResult func width(_ value: Double) -> Self
    @discardableResult func width(_ value: WidthValue) -> Self
    
    @discardableResult func height(_ value: Double) -> Self
    @discardableResult func height(_ value: Double, max: MaxHeightValue) -> Self
    @discardableResult func height(_ value: Double, max: Double) -> Self
    
    @discardableResult func height(_ value: HeightValue) -> Self
    @discardableResult func height(_ value: HeightValue, max: MaxHeightValue) -> Self
    @discardableResult func height(_ value: HeightValue, max: Double) -> Self
    
    @discardableResult func size(_ value: CGSize) -> Self
    @discardableResult func size(_ width: Double, _ height: Double?) -> Self
}

extension SizeSetter where Self: LayoutItem {
    public func size(_ value: CGSize) -> Self {
        attr.userWidth = .value(Double(value.width))
        attr.devWidth = Double(value.width)
        attr.userHeight = .value(Double(value.height))
        attr.devHeight = Double(value.height)
        return self
    }
    
    public func size(_ width: Double, _ height: Double?) -> Self {
        attr.userWidth = .value(Double(width))
        attr.devWidth = width
        if let height = height {
            attr.userHeight = .value(Double(height))
            attr.devHeight = height
        } else {
            attr.userHeight = .autoFit
        }
        return self
    }
    
    public func width(_ value: Double) -> Self {
        attr.userWidth = .value(Double(value))
        attr.devWidth = value
        return self
    }
    
    public func width(_ value: WidthValue) -> Self {
        switch value {
        case .grow(let fill): attr.userWidth = .grow(fill)
        case .full: attr.userWidth = .grow(.max)
        }
        return self
    }
    
    public func height(_ value: Double) -> Self {
        attr.userHeight = .value(Double(value))
        attr.devHeight = value
        return self
    }
    
    public func height(_ value: HeightValue) -> Self {
        switch value {
        case .autoFit: attr.userHeight = .autoFit
        case .full: attr.userHeight = .grow(.max)
        case .widthPerHeightRatio(let ew): attr.userHeight = .whRatio(ew)
        case .grow(let part): attr.userHeight = .grow(part)
        }
        return self
    }
    
    public func height(_ value: Double, max: MaxHeightValue) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: Double, max: Double) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: HeightValue, max: MaxHeightValue) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: HeightValue, max: Double) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    private func setMaxHeight(_ value: MaxHeightValue) {
        switch value {
        case .none: attr.userMaxHeight = .none
        case .fit: attr.userMaxHeight = .fit
        case .infinite: attr.userMaxHeight = .infinite
        }
    }
    
    private func setMaxHeight(_ value: Double) {
        attr.userMaxHeight = .value(value)
    }
    
//    public func min(height: Double) -> Self {
//        attr.minHeight = height
//        return self
//    }
}
