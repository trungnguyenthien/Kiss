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
            cell.config(width: cellWidth(), user: datasource[indexPath.row], isPortrait: isPortrait())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sampleCell.config(width: cellWidth(), user: datasource[indexPath.row], isPortrait: isPortrait())
        let size = sampleCell.kiss.estimatedSize(width: cellWidth(), height: nil)
        return size
    }
    
    
    func cellWidth() -> CGFloat {
        if isPortrait() {
            return (UIScreen.main.bounds.width - 5) / 4
        } else {
            return (UIScreen.main.bounds.width - 4) / 3
        }
    }
}

class UserKissCell: UICollectionViewCell {
    let mailLabel = "Email".labelMediumBold
    let titleLable = "Title".labelMediumBold
    let phoneNum = "PhoneNUm".labelMedium
    let image = makeView(.lightGray)
    let ratingView = RatingView()
    
    lazy var stackInfoLayout = makeView(.lightText).kiss.vstack {
        mailLabel.layout.marginTop(5).alignSelf(.center)
        titleLable.layout.marginTop(5)
        phoneNum.layout.marginTop(5)
        ratingView.layout.marginTop(5)
    }.grow(1).alignItems(.stretch).margin(5).alignSelf(.center)
    
    lazy var hLayout = hstack {
        image.layout.grow(1).ratio(1/1)
        stackInfoLayout
    }.padding(5).alignItems(.start)
    
    lazy var vLayout = vstack {
        image.layout.alignSelf(.stretch).ratio(2/2)
        stackInfoLayout
    }.padding(10).alignItems(.start)
    
    func config(width: CGFloat, user: User, isPortrait: Bool) {
        self.backgroundColor = .white
        mailLabel.text = user.email
        titleLable.text = "\(user.name.last) \(user.name.first)"
        phoneNum.text = "Tel: \(user.phone)"
        kiss.constructIfNeed(layout: isPortrait ? vLayout : hLayout)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
