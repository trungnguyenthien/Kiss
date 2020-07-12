import Foundation
import UIKit
import YogaKit

func trace(_ message: String) {
    print("💋💋 KissLog: " + message)
}

func setGrow(grow: Double, to layout: YGLayout) {
    let cgGrow = CGFloat(grow)
    layout.flexGrow = cgGrow
    layout.flexShrink = cgGrow
    layout.flex = cgGrow
}

func makeBlankView() -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    view.isUserInteractionEnabled = false
    return view
}
