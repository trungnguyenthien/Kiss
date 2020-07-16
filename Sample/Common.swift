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
