//
//  Common.swift
//  Kiss-Sample
//
//  Created by Trung on 6/30/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import UIBuilder

let small = 4.0
let medium = 8.0

func medium(text: String, line: Int) -> UILabel {
    let label = TextBuilder().fontSize(16).linebreak(.truncatingTail(line)).textColor(.darkText).label().cornerRadius(5)
    label.text = text
    return label
}

func large(text: String, line: Int) -> UILabel {
    let label = TextBuilder()
        .fontSize(16)
        .linebreak(.truncatingTail(line))
        .textColor(.black).label().cornerRadius(5)
    label.text = text
    return label
}

func view(_ color: UIColor) -> UIView {
    let view = UIView().cornerRadius(5)
    view.backgroundColor = color
    return view
}

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

extension UICollectionView {
    func reloadLayoutAfterRotating(coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.reloadItems(at: self.indexPathsForVisibleItems)
        }
        
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else { return }
            self.collectionViewLayout.invalidateLayout()
        }
    }
}
