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
/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func vstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> VStackLayout {
    let stack = VStackLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func vstack(@LayoutItemBuilder builder: () -> LayoutItem) -> VStackLayout {
    let stack = VStackLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - HSTACK LAYOUT

/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func hstack(@LayoutItemBuilder builder: () -> [LayoutItem]) -> HStackLayout {
    let stack = HStackLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func hstack(@LayoutItemBuilder builder: () -> LayoutItem) -> HStackLayout {
    let stack = HStackLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - WRAP LAYOUT
/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func wrap(@LayoutItemBuilder builder: () -> [LayoutItem]) -> WrapLayout {
    let stack = WrapLayout()
    stack.layoutItems.append(contentsOf: builder())
    return stack
}

/// <#Description#>
/// - Parameter builder: <#builder description#>
/// - Returns: <#description#>
public func wrap(@LayoutItemBuilder builder: () -> LayoutItem) -> WrapLayout {
    let stack = WrapLayout()
    stack.layoutItems.append(builder())
    return stack
}

// MARK: - SPACER
/// <#Description#>
/// - Parameter size: <#size description#>
/// - Returns: <#description#>
public func spacer(_ size: Double) -> Spacer {
    let spacer = Spacer(size: size)
    return spacer
}

/// <#Description#>
/// - Parameter grow: <#grow description#>
/// - Returns: <#description#>
public func growSpacer(_ grow: Double) -> Spacer {
    return Spacer(grow: grow)
}

/// <#Description#>
/// - Returns: <#description#>
public func stretchSpacer() -> Spacer {
    return Spacer()
}
