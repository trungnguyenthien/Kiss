
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
        widthValue = .value(Double(value.width))
        heightValue = .value(Double(value.height))
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
        widthValue = .fill(Int8.max)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFull(height: Double) -> Self {
        widthValue = .fill(Int8.max)
        heightValue = .value(height)
        return self
    }
    
    public func widthFull(height: HeightValue) -> Self {
        widthValue = .fill(Int8.max)
        heightValue = height
        return self
    }
    
    public func width(_ width: Double, height: Double) -> Self {
        widthValue = .value(width)
        heightValue = .value(height)
        return self
    }
    
    public func width(_ width: Double, height: HeightValue) -> Self {
        widthValue = .value(width)
        heightValue = height
        return self
    }
    
    public func width(_ width: Double, equalHeight: Double) -> Self {
        widthValue = .value(width)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFill(_ fill: Int8, equalHeight: Double) -> Self {
        widthValue = .fill(fill)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func widthFill(_ fill: Int8, height: Double) -> Self {
        widthValue = .fill(fill)
        heightValue = .value(height)
        return self
    }
    
    public func widthFill(_ fill: Int8, height: HeightValue) -> Self {
        widthValue = .fill(fill)
        heightValue = height
        return self
    }
}
