
import Foundation
import UIKit

public protocol SizeSetter {
    func min(height: Double) -> Self
//    func min(width: Double) -> Self
    
    func width(_ value: Double) -> Self
    func width(_ value: WidthValue) -> Self
    
    func height(_ value: Double) -> Self
    func height(_ value: HeightValue) -> Self
    
    func size(_ value: CGSize) -> Self
    func size(_ width: Double, _ height: Double?) -> Self
}

extension SizeSetter where Self: ViewLayout {
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
    
    public func min(height: Double) -> Self {
        attr.minHeight = height
        return self
    }
    
//    public func min(width: Double) -> Self {
//        minWidth = width
//        return self
//    }
    
}
