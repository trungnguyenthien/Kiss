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

    @IBOutlet weak var collectionView: UICollectionView!
    private let cellKind = CellKind.kisscell
    let sampleCell = UserKissCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(UserKissCell.self, forCellWithReuseIdentifier: CellKind.kisscell.rawValue)

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
                }
                
            case .failure(_):
                self.datasource.removeAll()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Reload visible item for updating it's layout
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else { return }
            // invalidateLayout for updating it's layout
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellKind.rawValue, for: indexPath)
        if let cell = cell as? UserKissCell {
            let cellWidth = (UIScreen.main.bounds.width - 5) / 4
            cell.config(width: cellWidth, user: datasource[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 5) / 4
        sampleCell.config(width: cellWidth, user: datasource[indexPath.row])
        let size = sampleCell.kiss.estimatedSize(width: cellWidth, height: nil)
        return size
    }
    
}

class UserKissCell: UICollectionViewCell {
    let orderLabel = "Order".labelMediumBold
    let titleLable = "Title".labelMediumBold
    let phoneNum = "PhoneNUm".labelMedium
    let image = makeView(.systemGray2)

    lazy var hLayout = makeView(.green).kiss
        .hstack {
            image.layout.grow(1).ratio(3/2)
            vstack {
                orderLabel.layout
                titleLable.layout
                phoneNum.layout
            }.grow(1).alignItems(.start).marginLeft(5).alignSelf(.center)
        }.padding(5).minHeight(120).alignItems(.start)
    
    lazy var vLayout = makeView(.yellow).kiss
        .vstack {
            image.layout.grow(1).ratio(2/2)
            vstack {
                orderLabel.layout.grow(1)
                phoneNum.layout.grow(1)
                titleLable.layout.grow(1)
            }.grow(1).alignItems(.start).marginLeft(5).alignSelf(.center)
        }.padding(5).minHeight(120).alignItems(.start)
    
    func config(width: CGFloat, user: User) {
        orderLabel.text = user.email
        titleLable.text = "\(user.name.last) \(user.name.first)"
        phoneNum.text = "Tel: \(user.phone)"
        let isVertical = width > 250
        kiss.constructIfNeed(layout: isVertical ? vLayout : hLayout)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
