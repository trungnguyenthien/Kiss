@_functionBuilder
public struct LayoutItemBuilder {
    public static func buildBlock(_ lItems: LayoutItem...) -> [LayoutItem] {
        lItems
    }
}

@_functionBuilder
public struct GroupLayoutBuilder {
    public static func buildBlock(_ groups: GroupLayout...) -> [GroupLayout] {
        groups
    }
}

// MARK: - VSTACK LAYOUT
public func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
    let stack = VStackLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

public func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
    let stack = VStackLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - HSTACK LAYOUT
public func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
    let stack = HStackLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

public func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
    let stack = HStackLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - WRAP LAYOUT
public func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
    let stack = WrapLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

public func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
    let stack = WrapLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - SPACER
public var spacer: Spacer {
    return Spacer()
}
