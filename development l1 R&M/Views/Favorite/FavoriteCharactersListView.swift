//  Created by Emilio

import SwiftUI

struct FavoriteCharactersListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        VStack(spacing: 0) {
            
            ScreenHeader(
                title: "Избранные",
                trailingButtons: [
                    AnyView(
                        Button {
                            favoritesManager.removeAllFavorites()
                        } label: {
                            Image(systemName: "trash")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                    ),
                    AnyView(
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                    )
                ]
            )
            
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
