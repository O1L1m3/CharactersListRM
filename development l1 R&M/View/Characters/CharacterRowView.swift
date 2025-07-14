//  Created by Emilio

import SwiftUI

struct CharacterRowView: View {
    let character: CharacterRM
    @ObservedObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel: CharacterDetailViewModel

    @State private var showingDetailSheet = false

    init(character: CharacterRM, favoritesManager: FavoritesManager) {
        self.character = character
        self.favoritesManager = favoritesManager
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character))
    }

    var body: some View {
        Button {
            showingDetailSheet = true
        } label: {
            VStack(alignment: .leading, spacing: 0){
                ZStack(alignment: .leading){
                    HStack(spacing: 0){
                        AsyncImage(url: URL(string: character.image), scale: 2.7) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "icloud.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 3){
                            let details: [(String, String)] = [
                                ("Имя:", viewModel.localizedName ?? ""),
                                ("Вид:", viewModel.localizedSpecies),
                                ("Гендер:", viewModel.localizedGender),
                                ("Статус:", viewModel.localizedStatus)
                            ]

                            ForEach(details, id: \.0) { label, value in
                                HStack(alignment: .top, spacing: 5) {
                                    Text(label)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.gray)
                                        .frame(width: 75, alignment: .trailing)

                                    Text(value)
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.colortext)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .shadow(radius: 1)

                                }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                
                        Spacer()

                        Button {
                            if favoritesManager.isFavorite(character: character) {
                                favoritesManager.removeFavorite(character: character)
                            } else {
                                favoritesManager.addFavorite(character: character)
                            }
                        } label: {
                            Image(systemName: favoritesManager.isFavorite(character: character) ? "star.fill" : "star")
                                .foregroundColor(favoritesManager.isFavorite(character: character) ? .white : .gray)
                        }
                        .padding(.trailing, 5)
                    }
                    .zIndex(1)

                    VStack(alignment: .leading){
                        Capsule()
                            .fill(.num1)
                            .shadow(color: .bg, radius: 8)
                    }

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(.num2)
            .clipShape(Capsule())
            .shadow(color: .num2, radius: 8)
        }
        .sheet(isPresented: $showingDetailSheet) {
            CharacterDetailView(character: character, favoritesManager: favoritesManager)
        }
    }
}


  
