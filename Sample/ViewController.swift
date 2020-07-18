//
//  ViewController.swift
//  Kiss-Sample
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import UIKit
import Kiss

enum CellKind: String {
    case kisscell
    case constraint
}

class ViewController: UIViewController {
    let provider = RamdomUserProvider()
    var datasource: [User] = []
    private let cache = CacheCellHeight()
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellKind = CellKind.kisscell
    let sampleCell = UIKitCell()
    
    var gridKind: CollectionGridKind {
        return CollectionGridKind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UIKitCell.self, forCellWithReuseIdentifier: CellKind.kisscell.rawValue)
        updateBackgroundColor()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 1
        }
        
        provider.request(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let listResult):
                self.datasource.append(contentsOf: listResult.results)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.updateBackgroundColor()
                    self.cache.clearAll()
                }
                
            case .failure(_):
                self.datasource.removeAll()
                self.collectionView.reloadData()
            }
        }
        
        cache.calculation = calculationHeight
    }
    
    func rowHeight(_ row: Int) -> CGFloat {
        let firstRowIndex = Int(CGFloat(row) / CGFloat(gridKind.columns)) * gridKind.columns
        var lastRowIndex = firstRowIndex + Int(gridKind.columns) - 1
        lastRowIndex = min(lastRowIndex, datasource.count - 1)
        let rowHeights = (firstRowIndex...lastRowIndex).map { cache.get(at: $0) }
        let max = rowHeights.max() ?? 0
//        print("row = \(row), \tfirstRowIndex = \(firstRowIndex), lastRowIndex = \(lastRowIndex), rowHeights = \(rowHeights), max = \(max)")
        return max
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Reload visible item for updating it's layout
        cache.clearAll()
        
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else { return }
            // invalidateLayout for updating it's layout
            self.collectionView.reloadData()
//            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func calculationHeight(_ row: Int) -> CGFloat {
        sampleCell.update(name: datasource[row].name.first, email: datasource[row].email)
        let size = sampleCell.size(hardWidth: Double(gridKind.cellWidth))
        return size.height
    }
    
    private func updateBackgroundColor() {
        collectionView.backgroundColor = datasource.isEmpty ? .white : .gray
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellKind.rawValue, for: indexPath)
        if let cell = cell as? UIKitCell {
            cell.update(name: datasource[indexPath.row].name.first, email: datasource[indexPath.row].email)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gridKind.cellWidth, height: rowHeight(indexPath.row))
    }
}



class CacheCellHeight {
    private var heightDict = [Int: CGFloat]()
    var calculation: ((Int) -> CGFloat)? = nil
    func clearAll() {
        heightDict.removeAll()
    }
    
    func get(at row: Int) -> CGFloat {
        if let value = heightDict[row] {
            return value
        }
        guard let calculation = calculation else { return 0 }
        let newValue = calculation(row)
        heightDict[row] = newValue
        return newValue
    }
}
