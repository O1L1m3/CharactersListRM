//  Created by Emilio

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterRM
    @ObservedObject var favoritesManager: FavoritesManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(.bottom)

                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Статус: \(character.status)")
                        .font(.headline)
                        .padding(.vertical, 2)
                    Text("Вид: \(character.species)")
                        .font(.headline)
                        .padding(.vertical, 2)
                    Text("Гендер: \(character.gender)")
                        .font(.headline)
                        .padding(.vertical, 2)
                }

                Spacer()
            }
            .navigationTitle("Детали персонажа")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}
