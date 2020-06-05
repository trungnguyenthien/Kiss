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
