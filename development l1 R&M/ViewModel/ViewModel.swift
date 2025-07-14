//  Created by Emilio

import Foundation

class ViewModel: ObservableObject {
    @Published var characterSet: Set<CharacterRM> = []
    @Published var character: [CharacterRM] = []
    
    var selectedStatus: FilterEnums.StatusFilter = .all
    var selectedGender: FilterEnums.GenderFilter = .all
    
    private let networService: INetworkService
    
    init(networkService: INetworkService) {
        self.networService = networkService
        getCharacter(status: .all, gender: .all)
    }
    
    func getCharacter(url: URL? = nil, status: FilterEnums.StatusFilter = .all, gender: FilterEnums.GenderFilter = .all) {
        if url == nil {
            self.characterSet = []
        }
        
        networService.fetchData(url: url, gender: gender.apiValue, status: status.apiValue) { [weak self] characterResponse in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.characterSet.formUnion(characterResponse.results)
                self.character = Array(self.characterSet).sorted { $0.id < $1.id }
                
                if let nextUrlString = characterResponse.info.next, let nextUrl = URL(string: nextUrlString) {
                    self.getCharacter(url: nextUrl, status: status, gender: gender)
                }
            }
        }
    }
}
