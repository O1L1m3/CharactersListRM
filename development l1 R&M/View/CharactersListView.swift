//  Created by Emilio

import SwiftUI

struct CharactersListView: View {
    @StateObject var vm = ViewModel(networkService: NetworkService())
    @State private var showingFilterSheet = false
    @State private var currentSelectedStatus: FilterEnums.StatusFilter = .all
    @State private var currentSelectedGender: FilterEnums.GenderFilter = .all
    
    var body: some View {
        VStack(spacing: 0) {
            CharactersListHeader(showingFilterSheet: $showingFilterSheet)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    LazyVStack(alignment: .leading, spacing: 15) {
                        ForEach(vm.character, id: \.self) { character in
                            CharacterRowView(character: character)
                        }
                    }
                }
                .padding()
            }
            .background(.bg)

        }
        .onAppear {
            vm.getCharacter(status: currentSelectedStatus, gender: currentSelectedGender)
        }
        .sheet(isPresented: $showingFilterSheet) {
            FilterView(selectedStatus: $currentSelectedStatus, selectedGender: $currentSelectedGender, isShowingFilterView: $showingFilterSheet)
                .onDisappear {
                    vm.getCharacter(status: currentSelectedStatus, gender: currentSelectedGender)
                }
        }
    }
}

#Preview {
    CharactersListView()
}
