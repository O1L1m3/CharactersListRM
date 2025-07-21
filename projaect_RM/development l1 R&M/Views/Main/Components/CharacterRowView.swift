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
        VStack(alignment: .leading, spacing: 0){
            ZStack(alignment: .leading){
                HStack(spacing: 0){
                    CharacterInfoBlock(
                        imageUrl: character.image,
                        imageSize: CGSize(width: 100, height: 100),
                        imageCornerRadius: 50,
                        labelAlignment: .trailing,
                        labelFrameAlignment: .trailing,
                        details: [
                            ("Имя:", viewModel.localizedName),
                            ("Вид:", viewModel.localizedSpecies),
                            ("Гендер:", viewModel.localizedGender),
                            ("Статус:", viewModel.localizedStatus)
                        ]
                    )
                    
                    Spacer()
                    
                    FavoriteButton(character: character, favoritesManager: favoritesManager)

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
        .onTapGesture {
            showingDetailSheet = true
        }
        .sheet(isPresented: $showingDetailSheet) {
            CharacterDetailView(character: character, favoritesManager: favoritesManager, viewModel: viewModel)
        }
    }
}



  
