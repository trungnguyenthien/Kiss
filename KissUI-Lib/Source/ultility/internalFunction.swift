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



func hasVisibleLayout(_ layout: LayoutAttribute) -> Bool {
    if let layout = layout as? SetViewLayout {
        var isVisible = false
        var hasVisibleViewLayout = false
        layout.subLayouts.forEach { (attribute) in
            guard let viewLayout = attribute as? ViewLayout else { return }
            
            isVisible = isVisible || hasVisibleLayout(viewLayout)
            hasVisibleViewLayout = hasVisibleViewLayout || isVisible
        }
        return isVisible && hasVisibleViewLayout
    } else if let viewLayout = layout as? ViewLayout {
        // view == nil --> INVISIBLE
        // has View + Hidden --> INVISIBLE
        // has View + Visible --> VISIBLE
        return viewLayout.view?.isVisible == true
    } else {
        return true
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
