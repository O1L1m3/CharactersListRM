//  Created by Emilio

import SwiftUI

class ViewModel: ObservableObject {
    @Published var character: [CharacterRM] = []

    var selectedStatus: FilterEnums.StatusFilter = .all
    var selectedGender: FilterEnums.GenderFilter = .all
    
    private let networService: INetworkService
    
    init(networkService: INetworkService) {
        self.networService = networkService
        getCharacter(status: .all, gender: .all)
    }

    func getCharacter(status: FilterEnums.StatusFilter = .all, gender: FilterEnums.GenderFilter = .all) {
        
        networService.fetchData(gender: gender == .all ? nil : gender.rawValue,
                                status: status == .all ? nil : status.rawValue)
        { [weak self] characterResponse in
            DispatchQueue.main.async {
                self?.character = characterResponse.results
            }
        }
    }
}
