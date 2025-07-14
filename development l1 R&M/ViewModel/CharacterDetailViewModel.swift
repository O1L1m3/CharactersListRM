//  Created by Emilio

import Foundation

class CharacterDetailViewModel: ObservableObject {
    let character: CharacterRM

    init(character: CharacterRM) {
        self.character = character
    }

    var localizedName: String? {
        return character.name
    }

    var localizedSpecies: String {
        return character.species.localizedCharacterDetail(for: "species")
    }

    var localizedGender: String {
        return character.gender.localizedCharacterDetail(for: "gender")
    }

    var localizedStatus: String {
        return character.status.localizedCharacterDetail(for: "status")
    }
}

extension String {
    func localizedCharacterDetail(for key: String) -> String {
        switch key {
        case "species":
            switch self {
            case "Human": return "Человек"
            case "Alien": return "Пришелец"
            case "Poopybutthole": return "Попибутхол"
            case "Mythological Creature": return "Мифологическое Существо"
            case "Robot": return "Робот"
            case "Cronenberg": return "Кроненберг"
            case "Humanoid": return "Гуманоид"
            case "Animal": return "Животное"
            case "unknown": return "Неизвестно"
            default: return self
            }
        case "gender":
            switch self {
            case "Male": return "Мужской"
            case "Female": return "Женский"
            case "Genderless": return "Неопределен"
            case "unknown": return "Неизвестно"
            default: return self
            }
        case "status":
            switch self {
            case "Alive": return "Жив"
            case "Dead": return "Мертв"
            case "unknown": return "Неизвестно"
            default: return self
            }
        default: return self
        }
    }
}
