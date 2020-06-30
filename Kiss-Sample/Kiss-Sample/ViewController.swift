//
//  ViewController.swift
//  Kiss-Sample
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import UIKit
import KissUI

enum CellKind: String {
    case kisscell
    case constraint
}

class ViewController: UIViewController {
    let provider = RamdomUserProvider()
    var datasource: [User] = []
    private let collectionView = makeCollection()
    private let cellKind = CellKind.kisscell
    let sampleCell = UserKissCell()
    private lazy var regularLayout = {
        vstack {
            collectionView.layout.grow(1).alignSelf(.stretch)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserKissCell.self, forCellWithReuseIdentifier: CellKind.kisscell.rawValue)
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = true

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 1
        }
        
        provider.request(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let listResult):
                //                print(listResult)
                self.datasource.append(contentsOf: listResult.results)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(_):
                self.datasource.removeAll()
                self.collectionView.reloadData()
            }
        }
        view.kiss.constructIfNeed(layout: regularLayout)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        view.kiss.updateChange(width: view.bounds.width, height: view.bounds.height)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellKind.rawValue, for: indexPath)
        if let cell = cell as? UserKissCell {
            let cellWidth = (UIScreen.main.bounds.width - 3) / 3
            cell.config(width: cellWidth, user: datasource[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 3) / 3
        sampleCell.config(width: cellWidth, user: datasource[indexPath.row])
        let size = sampleCell.kiss.estimatedSize(width: cellWidth, height: nil)
        return size
    }
    
}

class UserKissCell: UICollectionViewCell {
    let titleLable = "Title".labelMediumBold
    let phoneNum = "PhoneNUm".labelMedium
    let image = makeView(.systemGray2)

    lazy var hLayout = makeView(.green).kiss
        .hstack {
            image.layout.grow(1).ratio(3/2).minHeight(120)
            vstack {
                titleLable.layout
                phoneNum.layout
            }.grow(1).alignItems(.start).marginLeft(5).alignSelf(.center)
        }.padding(5).minHeight(120).alignItems(.start)
    
    lazy var vLayout = makeView(.blue).kiss
        .vstack {
            image.layout.grow(1).ratio(3/2).minHeight(120)
            vstack {
                titleLable.layout
                phoneNum.layout
            }.grow(1).alignItems(.start).marginLeft(5).alignSelf(.center)
        }.padding(5).minHeight(120).alignItems(.start)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(width: CGFloat, user: User) {
        titleLable.text = "\(user.name.last): \(user.name.first)"
        phoneNum.text = "Tel: \(user.phone)"
        kiss.constructIfNeed(layout: width > 300 ? hLayout : vLayout)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
