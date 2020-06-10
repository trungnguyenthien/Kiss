import Foundation
import UIKit

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

func fitSizeSetLayout(of layout: LayoutAttribute) -> CGSize? {
    guard isVisibledLayout(layout) else { return .zero }
    
    if let setViewLayout = layout as? SetViewLayout {
        var minX = Double.max
        var minY = Double.max
        var maxX = Double.min
        var maxY = Double.min
        
        setViewLayout.subLayouts.forEach { (attr) in
            if let subExpectedX = attr.expectedX {
                minX = min(minX, subExpectedX)
                if let subExpectedWidth = attr.expectedWidth {
                    maxX = max(maxX, subExpectedX + subExpectedWidth)
                }
            }
            
            if let subExpectedY = attr.expectedY {
                minY = min(minY, subExpectedY)
                if let subExpectedHeight = attr.expectedHeight {
                    maxY = max(maxY, subExpectedY + subExpectedHeight)
                }
            }
        }
        if minX == .max || minY == .max || maxX == .min || maxY == .min {
            return nil
        }
        return CGSize(width: maxX - minX + layout.paddingLeft + layout.paddingRight,
                      height: maxY - minY + layout.paddingBottom + layout.paddingTop)
    }
    
    return .zero
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
