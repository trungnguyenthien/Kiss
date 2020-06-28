//
//  PokeProvider.swift
//  MemCache
//
//  Created by グエンティエン　チュン on 6/9/20.
//  Copyright © 2020 Yahoo!Japan. All rights reserved.
//

import Foundation

struct PokeProvider {
    private let notFoundError = NSError(domain: "Pokemon Not Found", code: 404, userInfo: nil)
    private let baseURL = "https://raw.githubusercontent.com/trungnguyenthien/pokemon/master/json/"
    private func makeUrl(page: Int) -> String {
        return baseURL + "p_\(page).json"
    }
    let session = URLSession.shared
    func request(page: Int, responseHandler: @escaping (Result<[Pokemon], Error>) -> Void) {
        var request = URLRequest(url: URL(string: makeUrl(page: page))!)
        request.httpMethod = "GET" 
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let error = error {
                responseHandler(.failure(error))
                return
            }
            
            do {
                guard let data = data else {
                    throw self.notFoundError
                }
                let pokes = try! JSONDecoder().decode([Pokemon].self, from: data)
                responseHandler(.success(pokes))
            } catch {
                responseHandler(.failure(error))
            }
        })

        task.resume()
    }
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let nationalNumber: String?
    let evolution: Evolution?
    let sprites: Sprites?
    let name: String?
    let type: [String]?
    let total, hp, attack, defense: Int?
    let spAtk, spDef, speed: Int?

    enum CodingKeys: String, CodingKey {
        case nationalNumber = "national_number"
        case evolution, sprites, name, type, total, hp, attack, defense
        case spAtk = "sp_atk"
        case spDef = "sp_def"
        case speed
    }
}

struct Sprites: Codable {
    let normal: String?
    let large: String?
    let animated: String?
}

struct Evolution: Codable {
    let name: String?
}
