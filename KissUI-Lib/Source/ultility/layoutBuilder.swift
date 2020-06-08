@_functionBuilder
public struct ViewBuilder {
    public static func buildBlock(_ items: LayoutAttribute...) -> [LayoutAttribute] {
        items
    }
}

// MARK: - VSTACK LAYOUT
public func vstack(@ViewBuilder builder: () -> [LayoutAttribute]) -> VStackLayout {
    let stack = VStackLayout()
    stack.subLayouts.append(contentsOf: builder())
    return stack
}

public func vstack(@ViewBuilder builder: () -> LayoutAttribute) -> VStackLayout {
    let stack = VStackLayout()
    stack.subLayouts.append(builder())
    return stack
}

// MARK: - HSTACK LAYOUT
public func hstack(@ViewBuilder builder: () -> [LayoutAttribute]) -> HStackLayout {
    let stack = HStackLayout()
    stack.subLayouts.append(contentsOf: builder())
    return stack
}

public func hstack(@ViewBuilder builder: () -> LayoutAttribute) -> HStackLayout {
    let stack = HStackLayout()
    stack.subLayouts.append(builder())
    return stack
}

// MARK: - WRAP LAYOUT
public func wrap(@ViewBuilder builder: () -> [LayoutAttribute]) -> WrapLayout {
    let stack = WrapLayout()
    stack.subLayouts.append(contentsOf: builder())
    return stack
}

public func wrap(@ViewBuilder builder: () -> LayoutAttribute) -> WrapLayout {
    let stack = WrapLayout()
    stack.subLayouts.append(builder())
    return stack
}

// MARK: - SPACER
public var vspacer: VSpacer {
    return VSpacer()
}

public var hspacer: HSpacer {
    return HSpacer();
}
