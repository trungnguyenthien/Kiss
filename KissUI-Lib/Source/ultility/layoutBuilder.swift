@_functionBuilder
public struct LayoutItemBuilder {
    public static func buildBlock(_ lItems: LayoutItem...) -> [LayoutItem] {
        lItems
    }
}

// MARK: - VSTACK LAYOUT
public func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
    let stack = VStackLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
    let stack = VStackLayout()
    stack.subItems.append(builder())
    return stack
}

// MARK: - HSTACK LAYOUT
public func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
    let stack = HStackLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
    let stack = HStackLayout()
    stack.subItems.append(builder())
    return stack
}

// MARK: - WRAP LAYOUT
public func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
    let stack = WrapLayout()
    stack.subItems.append(contentsOf: builder())
    return stack
}

public func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
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
