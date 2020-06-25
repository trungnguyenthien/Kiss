    case .bottom: group.layoutItems.append(spacer)
    case .center:
        group.layoutItems.append(spacer)
        group.layoutItems.insert(spacer, at: 0)
    }
    
    group.fullOptimize()
