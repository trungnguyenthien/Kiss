@_functionBuilder
public struct ViewBuilder {
    public static func buildBlock(_ items: LayoutItem...) -> [LayoutItem] {
        items
    }
}

// MARK: - VSTACK LAYOUT
public func vstack(@ViewBuilder builder: () -> [LayoutItem]) -> VStackLayout {
    let stack = VStackLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func vstack(@ViewBuilder builder: () -> LayoutItem) -> VStackLayout {
    let stack = VStackLayout()
    stack.subItems.append(builder())
    return stack
}

// MARK: - HSTACK LAYOUT
public func hstack(@ViewBuilder builder: () -> [LayoutItem]) -> HStackLayout {
    let stack = HStackLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func hstack(@ViewBuilder builder: () -> LayoutItem) -> HStackLayout {
    let stack = HStackLayout()
    stack.subItems.append(builder())
    return stack
}

// MARK: - WRAP LAYOUT
public func wrap(@ViewBuilder builder: () -> [LayoutItem]) -> WrapLayout {
    let stack = WrapLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func wrap(@ViewBuilder builder: () -> LayoutItem) -> WrapLayout {
    let stack = WrapLayout()
    stack.subItems.append(builder())
    return stack
}

// MARK: - SPACER
public var spacer: Spacer {
    return Spacer()
}

var temptSpacer: _TemptSpacer {
    return _TemptSpacer()
}
