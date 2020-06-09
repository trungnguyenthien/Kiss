
import Foundation
import UIKit

public protocol SizeSetter {
    func min(height: Double) -> Self
    func min(width: Double) -> Self
    
    func width(_ value: Double) -> Self
    func width(_ value: WidthValue) -> Self
    
    func height(_ value: Double) -> Self
    func height(_ value: HeightValue) -> Self
    
    func size(_ value: CGSize) -> Self
    func size(_ width: Double, _ height: Double?) -> Self
}

extension SizeSetter where Self: ViewLayout {
    public func size(_ value: CGSize) -> Self {
        widthDesignValue = .value(Double(value.width))
        expectedWidth = KFloat(value.width)
        heightDesignValue = .value(Double(value.height))
        expectedHeight = KFloat(value.height)
        return self
    }
    
    public func size(_ width: Double, _ height: Double?) -> Self {
        widthDesignValue = .value(Double(width))
        expectedWidth = width
        if let height = height {
            heightDesignValue = .value(Double(height))
            expectedHeight = height
        } else {
            heightDesignValue = .fit
        }
        return self
    }
    
    public func width(_ value: Double) -> Self {
        widthDesignValue = .value(Double(value))
        expectedWidth = value
        return self
    }
    
    public func width(_ value: WidthValue) -> Self {
        switch value {
        case .fillRemain(let fill):
            widthDesignValue = .fillRemain(fill)
        case .full: widthDesignValue = .fillRemain(Double.max)
        case .fit: widthDesignValue = .fit
        }
        return self
    }
    
    public func height(_ value: Double) -> Self {
        heightDesignValue = .value(Double(value))
        expectedHeight = value
        return self
    }
    
    public func height(_ value: HeightValue) -> Self {
        switch value {
        case .fit: heightDesignValue = .fit
        case .full: heightDesignValue = .fillRemain(Double.max)
        case .equalWidth(let ew): heightDesignValue = .equalWidth(ew)
        case .fillRemain(let part): heightDesignValue = .fillRemain(part)
        }
        return self
    }
    
    public func min(height: Double) -> Self {
        minHeight = height
        return self
    }
    
    public func min(width: Double) -> Self {
        minWidth = width
        return self
    }
    
}
