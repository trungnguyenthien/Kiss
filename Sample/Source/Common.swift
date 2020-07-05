//
//  Common.swift
//  Kiss-Sample
//
//  Created by Trung on 6/30/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit

let small = 4.0
let medium = 8.0

extension UIImageView {
    func download(url: String) {
        guard let url = URL(string: url) else { return }
        download(url: url)
    }
    
    func download(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
func isPortrait() -> Bool {
    return UIScreen.main.bounds.width < UIScreen.main.bounds.height
}

func makeThumbnail() -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .gray
    return imageView
}


func makeIconImage(name: String, size: Double) -> UIImageView {
    let imageView = UIImageView()
    imageView.image = UIImage(named: name)
    imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
    return imageView
}


func makeCollection() -> UICollectionView {
    let clayout = UICollectionViewFlowLayout.init()
    clayout.scrollDirection = .vertical
    let collection = UICollectionView(frame: .zero, collectionViewLayout: clayout)
    collection.alwaysBounceVertical = true
    collection.isUserInteractionEnabled = true
    return collection
}


func makeView(_ color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
}

extension String {
    var label: UILabel {
        let view = UILabel()
        view.backgroundColor = .quaternarySystemFill
        view.text = self
        view.numberOfLines = 0
        return view;
    }
    
    var labelSmall: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }
    
    var labelMedium: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    var labelMediumBold: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }
    
    var labelBigBold: UILabel {
        let label = self.label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }
}
