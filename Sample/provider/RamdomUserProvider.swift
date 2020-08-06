import Foundation

struct RamdomUserProvider {
    private let notFoundError = NSError(domain: "User Not Found", code: 404, userInfo: nil)
    private let baseURL = "https://randomuser.me/api/?results=50&nat=us&page="
    private func makeUrl(page: Int) -> String {
        return baseURL + "\(page)"
    }
    let session = URLSession.shared
    func request(page: Int, responseHandler: @escaping (Result<ListUserResult, Error>) -> Void) {
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
                let pokes = try! JSONDecoder().decode(ListUserResult.self, from: data)
                responseHandler(.success(pokes))
            } catch {
                responseHandler(.failure(error))
            }
        })

        task.resume()
    }
}


// MARK: - Response
struct ListUserResult: Codable {
    let results: [User]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct User: Codable {
    let gender: Gender
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - ID
struct ID: Codable {
    let name: String
    let value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String?

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription
    }
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
