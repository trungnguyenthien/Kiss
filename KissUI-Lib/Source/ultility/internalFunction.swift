func allLayoutAttributes(from layout: LayoutAttribute) -> [LayoutAttribute] {
    var output = [LayoutAttribute]()
    if let setlayout = layout as? SetViewLayout {
        output.append(setlayout)
        output.append(contentsOf: allLayoutAttributes(from: setlayout))
    } else {
        output.append(layout)
    }
    return output
}
