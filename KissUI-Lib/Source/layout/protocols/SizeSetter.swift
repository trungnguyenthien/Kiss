
import Foundation
import UIKit

public enum DesignWidthValue {
    case value(Double)
    case grow(Double) // full = grow(9999999999999)
    case autoFit
}

public enum WidthValue {
    case grow(Double)
    case full
}

public enum DesignHeightValue {
    case value(Double)
    case autoFit
    case whRatio(Double)
    case grow(Double)
}

public enum HeightValue {
    case autoFit
    case full
    // height / width
    case widthPerHeightRatio(Double)
    case grow(Double)
}

public enum DesignMaxHeightValue {
    case none
    case fit
    case infinite
}

public enum MaxHeightValue {
    case none
    case value(Double)
    case infinite
    case fit
}

public protocol SizeSetter {
    @discardableResult func width(_ value: Double) -> Self
    @discardableResult func width(_ value: WidthValue) -> Self
    
    @discardableResult func height(_ value: Double) -> Self
    @discardableResult func height(_ value: Double, max: DesignMaxHeightValue) -> Self
    @discardableResult func height(_ value: Double, max: Double) -> Self
    
    @discardableResult func height(_ value: HeightValue) -> Self
    @discardableResult func height(_ value: HeightValue, max: DesignMaxHeightValue) -> Self
    @discardableResult func height(_ value: HeightValue, max: Double) -> Self
    
    @discardableResult func size(_ value: CGSize) -> Self
    @discardableResult func size(_ width: Double, _ height: Double?) -> Self
}

extension SizeSetter where Self: LayoutItem {
    public func size(_ value: CGSize) -> Self {
        attr.widthDesignValue = .value(Double(value.width))
        attr.expectedWidth = Double(value.width)
        attr.heightDesignValue = .value(Double(value.height))
        attr.expectedHeight = Double(value.height)
        return self
    }
    
    public func size(_ width: Double, _ height: Double?) -> Self {
        attr.widthDesignValue = .value(Double(width))
        attr.expectedWidth = width
        if let height = height {
            attr.heightDesignValue = .value(Double(height))
            attr.expectedHeight = height
        } else {
            attr.heightDesignValue = .autoFit
        }
        return self
    }
    
    public func width(_ value: Double) -> Self {
        attr.widthDesignValue = .value(Double(value))
        attr.expectedWidth = value
        return self
    }
    
    public func width(_ value: WidthValue) -> Self {
        switch value {
        case .grow(let fill): attr.widthDesignValue = .grow(fill)
        case .full: attr.widthDesignValue = .grow(.max)
        }
        return self
    }
    
    public func height(_ value: Double) -> Self {
        attr.heightDesignValue = .value(Double(value))
        attr.expectedHeight = value
        return self
    }
    
    public func height(_ value: HeightValue) -> Self {
        switch value {
        case .autoFit: attr.heightDesignValue = .autoFit
        case .full: attr.heightDesignValue = .grow(.max)
        case .widthPerHeightRatio(let ew): attr.heightDesignValue = .whRatio(ew)
        case .grow(let part): attr.heightDesignValue = .grow(part)
        }
        return self
    }
    
    public func height(_ value: Double, max: DesignMaxHeightValue) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: Double, max: Double) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: HeightValue, max: DesignMaxHeightValue) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    public func height(_ value: HeightValue, max: Double) -> Self {
        height(value)
        setMaxHeight(max)
        return self
    }
    
    private func setMaxHeight(_ value: DesignMaxHeightValue) {
        switch value {
        case .none: attr.maxHeight = .none
        case .fit: attr.maxHeight = .fit
        case .infinite: attr.maxHeight = .infinite
        }
    }
    
    private func setMaxHeight(_ value: Double) {
        attr.maxHeight = .value(value)
    }
    
//    public func min(height: Double) -> Self {
//        attr.minHeight = height
//        return self
//    }
}
