//  Created by Emilio

import SwiftUI

struct FavoriteButton: View {
    let character: CharacterRM
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        Button {
            if favoritesManager.isFavorite(character: character) {
                favoritesManager.removeFavorite(character: character)
            } else {
                favoritesManager.addFavorite(character: character)
            }
        } label: {
            Image(systemName: favoritesManager.isFavorite(character: character) ? "star.fill" : "star")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}
