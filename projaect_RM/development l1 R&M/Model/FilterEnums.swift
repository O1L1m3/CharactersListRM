//  Created by Emilio

import Foundation

struct FilterEnums {

    enum StatusFilter: String, CaseIterable, Identifiable {
        case all = "Все"
        case alive = "Жив"
        case dead = "Мертв"
        case unknown = "Неизвестно"

        var id: String { self.rawValue }

        var apiValue: String? {
            switch self {
            case .all: return nil
            case .alive: return "Alive"
            case .dead: return "Dead"
            case .unknown: return "unknown"
            }
        }
    }

    enum GenderFilter: String, CaseIterable, Identifiable {
        case all = "Все"
        case male = "Мужской"
        case female = "Женский"
        case genderless = "Неопределен"
        case unknown = "Неизвестно"

        var id: String { self.rawValue }

        var apiValue: String? {
            switch self {
            case .all: return nil
            case .male: return "Male"
            case .female: return "Female"
            case .genderless: return "Genderless"
            case .unknown: return "unknown"
            }
        }
    }
}
