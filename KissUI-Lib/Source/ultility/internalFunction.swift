import Foundation
import UIKit

func trace(_ message: String) {
    print(message)
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


