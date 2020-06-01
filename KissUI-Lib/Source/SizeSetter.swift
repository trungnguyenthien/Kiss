
import Foundation


public protocol SizeSetter {
    func size(width: Double, height: Double) -> Self
    func size(width: Double, height: HeightValue) -> Self
    func size(width: Double, equalHeight: Double) -> Self
    
    func sizeFillWidth(_ fill: Int8, equalHeight: Double) -> Self
    func sizeFillWidth(_ fill: Int8, height: Double) -> Self
    func sizeFillWidth(_ fill: Int8, height: HeightValue) -> Self
    
    func sizeFitWidth(height: Double) -> Self
    func sizeFitWidth(height: HeightValue) -> Self
    
    func sizeFullWidth(equalHeight: Double) -> Self
    func sizeFullWidth(height: Double) -> Self
    func sizeFullWidth(height: HeightValue) -> Self
}

extension LayoutAttribute: SizeSetter {
    public func sizeFullWidth(equalHeight: Double) -> Self {
        widthValue = .fill(Int8.max)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func sizeFullWidth(height: Double) -> Self {
        widthValue = .fill(Int8.max)
        heightValue = .value(height)
        return self
    }
    
    public func sizeFullWidth(height: HeightValue) -> Self {
        widthValue = .fill(Int8.max)
        heightValue = height
        return self
    }
    
    public func size(width: Double, height: Double) -> Self {
        widthValue = .value(width)
        heightValue = .value(height)
        return self
    }
    
    public func size(width: Double, height: HeightValue) -> Self {
        widthValue = .value(width)
        heightValue = height
        return self
    }
    
    public func size(width: Double, equalHeight: Double) -> Self {
        widthValue = .value(width)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func sizeFillWidth(_ fill: Int8, equalHeight: Double) -> Self {
        widthValue = .fill(fill)
        heightValue = .equalWidth(1/equalHeight)
        return self
    }
    
    public func sizeFillWidth(_ fill: Int8, height: Double) -> Self {
        widthValue = .fill(fill)
        heightValue = .value(height)
        return self
    }
    
    public func sizeFillWidth(_ fill: Int8, height: HeightValue) -> Self {
        widthValue = .fill(fill)
        heightValue = height
        return self
    }
    
    public func sizeFitWidth(height: Double) -> Self {
        widthValue = .fit
        heightValue = .value(height)
        return self
    }
    
    public func sizeFitWidth(height: HeightValue) -> Self {
        widthValue = .fit
        heightValue = height
        return self
    }
}
