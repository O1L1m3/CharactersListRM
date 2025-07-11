import SwiftUI

class ViewModel: ObservableObject {
    @Published var character: [CharacterRM] = []
    
    var selectedStatus: String = "All"
    var selectedGender: String = "All"
    
    private let networService: INetworkService
    
    init(networkService: INetworkService) {
        self.networService = networkService
        getCharacter(status: selectedStatus, gender: selectedGender)
    }

    func getCharacter(status: String = "All", gender: String = "All") {
        networService.fetchData(gender: gender == "All" ? nil : gender,
                                status: status == "All" ? nil : status)
        { [weak self] characterResponse in
            DispatchQueue.main.async {
                self?.character = characterResponse.results
            }
        }
    }
}
