//  Created by Emilio

import Foundation

struct ResultRM: Decodable, Hashable{
    let count: Int?
    let results: [CharacterRM]
}

struct CharacterRM: Decodable, Hashable{
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let image: String?

}

