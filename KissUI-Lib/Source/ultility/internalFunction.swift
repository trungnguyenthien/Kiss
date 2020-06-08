import Foundation

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


// Has at least one Visible View
func isVisibledLayout(_ selfLayout: LayoutAttribute) -> Bool {
    if let setViewLayout = selfLayout as? SetViewLayout {
        var hasVisibleViewLayout = false
        setViewLayout.subLayouts.forEach { (attribute) in
            guard let viewLayout = attribute as? ViewLayout else { return }
            // Make sure layoutAttribute is not Spacer
            hasVisibleViewLayout = hasVisibleViewLayout || isVisibledLayout(viewLayout)
        }
        return hasVisibleViewLayout
    } else if let viewLayout = selfLayout as? ViewLayout {
        // view == nil --> INVISIBLE
        // has View + Hidden --> INVISIBLE
        // has View + Visible --> VISIBLE
        return viewLayout.view?.isVisible == true
    } else {
        // VSpace, HSpacer
        return false
    }
}

func trace(_ message: String) {
    print(message)
}

func traceClassName(_ obj: Any, message: String) {
    if let obj = obj as? ViewLayout {
        let name = obj.id ?? className(obj.view)
        trace("\(name): \(message)")
    } else {
        trace("\(className(obj)): \(message)")
    }
}


func className(_ obj: Any) -> String {
    return String(describing: type(of: obj))
}
