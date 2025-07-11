//  Created by Emilio

import SwiftUI

class ViewModel: ObservableObject{
    @Published var character: [CharacterRM] = []
    private let network = NetworkLayer()
    
    func getCharacter(){
        network.fetchData(species: "Alien", gender: "Male") {[weak self] character in
            DispatchQueue.main.async {
                self?.character = character.results

            }
        }
    }
}
