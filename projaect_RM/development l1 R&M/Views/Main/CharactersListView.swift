//  Created by Emilio

import SwiftUI

struct CharactersListView: View {
    @StateObject var vm = ViewModel(service: NetworkService())
    @StateObject var favoritesManager = FavoritesManager()

    @State private var showingFilterSheet = false
    @State private var showingFavoritesSheet = false
    @State private var currentSelectedStatus: FilterEnums.StatusFilter = .all
    @State private var currentSelectedGender: FilterEnums.GenderFilter = .all
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            CharactersListHeader(showingFilterSheet: $showingFilterSheet, showingFavoritesSheet: $showingFavoritesSheet)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    LazyVStack(alignment: .leading, spacing: 15) {
                        ForEach(vm.character, id: \.id) { character in
                            CharacterRowView(character: character, favoritesManager: favoritesManager)
                        }
                    }
                }
                .padding()
            }
            .background(.bg)
        }
        .sheet(isPresented: $showingFilterSheet) {
                    FilterView(
                        selectedStatus: $currentSelectedStatus,
                        selectedGender: $currentSelectedGender,
                        isShowingFilterView: $showingFilterSheet
                    )
                    .onDisappear {
                        Task {
                            await vm.loadCharacters(
                                status: currentSelectedStatus,
                                gender: currentSelectedGender
                            )
                        }
                    }
                }
                .sheet(isPresented: $showingFavoritesSheet) {
                    FavoriteCharactersListView(favoritesManager: favoritesManager)
                }
    }
}

#Preview {
    CharactersListView()
}
