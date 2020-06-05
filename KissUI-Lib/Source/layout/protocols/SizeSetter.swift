
import Foundation
import UIKit

public protocol SizeSetter {
    func width(_ width: Double, height: Double) -> Self
    func width(_ width: Double, height: HeightValue) -> Self
    func width(_ width: Double, equalHeight: Double) -> Self
    
    func widthFill(_ fill: Int8, equalHeight: Double) -> Self
    func widthFill(_ fill: Int8, height: Double) -> Self
    func widthFill(_ fill: Int8, height: HeightValue) -> Self
    
    func widthFull(equalHeight: Double) -> Self
    func widthFull(height: Double) -> Self
    func widthFull(height: HeightValue) -> Self
    
    func min(height: Double) -> Self
    func min(width: Double) -> Self
    
    func size(_ value: CGSize) -> Self
}

extension SizeSetter where Self: ViewLayout {
    public func size(_ value: CGSize) -> Self {
        widthDesignValue = .value(Double(value.width))
        heightDesignValue = .value(Double(value.height))
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
    
    public func widthFull(equalHeight: Double) -> Self {
        widthDesignValue = .fill(Int8.max)
        heightDesignValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFull(height: Double) -> Self {
        widthDesignValue = .fill(Int8.max)
        heightDesignValue = .value(height)
        return self
    }
    
    public func widthFull(height: HeightValue) -> Self {
        widthDesignValue = .fill(Int8.max)
        heightDesignValue = height
        return self
    }
    
    public func width(_ width: Double, height: Double) -> Self {
        widthDesignValue = .value(width)
        heightDesignValue = .value(height)
        return self
    }
    
    public func width(_ width: Double, height: HeightValue) -> Self {
        widthDesignValue = .value(width)
        heightDesignValue = height
        return self
    }
    
    public func width(_ width: Double, equalHeight: Double) -> Self {
        widthDesignValue = .value(width)
        heightDesignValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFill(_ fill: Int8, equalHeight: Double) -> Self {
        widthDesignValue = .fill(fill)
        heightDesignValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFill(_ fill: Int8, height: Double) -> Self {
        widthDesignValue = .fill(fill)
        heightDesignValue = .value(height)
        return self
    }
    
    public func widthFill(_ fill: Int8, height: HeightValue) -> Self {
        widthDesignValue = .fill(fill)
        heightDesignValue = height
        return self
    }
}
