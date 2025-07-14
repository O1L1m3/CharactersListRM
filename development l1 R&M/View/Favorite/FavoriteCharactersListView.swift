//  Created by Emilio

import SwiftUI

struct FavoriteCharactersListView: View {
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Избранные")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Button("Очистить") {
                    favoritesManager.removeAllFavorites()
                }
                .foregroundColor(.white)
                .padding(.horizontal)
            }
            .padding()
            .background(.bg)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    if favoritesManager.favoriteCharacters.isEmpty {
                        Text("Нет избранных")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVStack(alignment: .leading, spacing: 15) {
                            ForEach(favoritesManager.favoriteCharacters, id: \.self) { character in
                                CharacterRowView(character: character, favoritesManager: favoritesManager)
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bg)
        }
    }
}
