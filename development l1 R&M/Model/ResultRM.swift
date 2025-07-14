//  Created by Emilio

import Foundation

struct ResultRM: Decodable, Hashable{
    let info: Info
    let results: [CharacterRM]
}

struct Info: Codable, Hashable {
    let count: Int
    let pages: Int
    let next: String?
}

struct CharacterRM: Codable, Hashable, Identifiable{
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String

}

