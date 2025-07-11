//  Created by Emilio

import SwiftUI

class ViewModel: ObservableObject{
    @Published var character: [CharacterRM] = []
    private let networService: INetworkService
    
    init(networkService: INetworkService) {
        self.networService = networkService
        getCharacter()
    }
    
    func getCharacter(){
        networService.fetchData(species: "Alien", gender: "Male") {[weak self] character in
            DispatchQueue.main.async {
                self?.character = character.results

            }
        }
    }
}
