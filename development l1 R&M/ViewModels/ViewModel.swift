//  Created by Emilio

import Foundation

@MainActor
final class ViewModel: ObservableObject {
    @Published var characterSet: Set<CharacterRM> = []
    @Published var character: [CharacterRM] = []

    var selectedStatus: FilterEnums.StatusFilter = .all
    var selectedGender: FilterEnums.GenderFilter = .all

    private let service: INetworkService
    
    init(service: INetworkService) {
        self.service = service
        Task {
            await loadCharacters(status: .all, gender: .all)
        }
    }

    func loadCharacters(status: FilterEnums.StatusFilter = .all, gender: FilterEnums.GenderFilter = .all) async {
        characterSet = []

        do {
            let allCharacters = try await service.fetchData(
                status: status.apiValue,
                gender: gender.apiValue
            )

            characterSet = Set(allCharacters)
            character = Array(characterSet).sorted { $0.id < $1.id }

        } catch {
            print("Ошибка загрузки персонажей: \(error.localizedDescription)")
        }
    }
}
