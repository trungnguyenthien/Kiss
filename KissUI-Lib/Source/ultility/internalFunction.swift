import Foundation
import UIKit

func trace(_ message: String) {
    print(message)
}

func traceClassName(_ obj: Any, message: String) {
    if let obj = obj as? ViewLayout {
        let name = className(obj.view)
        trace("\(name): \(message)")
    } else {
        trace("\(className(obj)): \(message)")
    }
}


func className(_ obj: Any) -> String {
    return String(describing: type(of: obj))
}

func printWarning(_ message: String) {
    trace("⚠️ KISSUI: " + message)
}

func throwError(_ message: String) {
    trace("🔴 KISSUI: " + message)
    fatalError("🔴 KISSUI: " + message)
}


internal extension LayoutItem {
    var attr: LayoutAttribute {
        if let item = self as? ViewLayout {
            return item.attr
        }
        return (self as! LayoutAttribute)
    }
}
func attr(_ item: LayoutItem) -> LayoutAttribute {
    if let item = item as? ViewLayout {
        return item.attr
    }
    return (item as! LayoutAttribute)
}

func isSetLayout(_ item: LayoutItem) -> Bool {
    return item is SetViewLayout
}

