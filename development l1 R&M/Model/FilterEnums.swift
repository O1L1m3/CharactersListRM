//  Created by Emilio

import Foundation

struct FilterEnums {
    
    enum StatusFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"

        var id: String { self.rawValue }
    }

    enum GenderFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown = "unknown"

        var id: String { self.rawValue }
    }
}
