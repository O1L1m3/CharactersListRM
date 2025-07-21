//  Created by Emilio

import SwiftUI

struct CharactersListHeader: View {
    
    @Binding var showingFilterSheet: Bool
    @Binding var showingFavoritesSheet: Bool
    
    var body: some View {
        HStack {
            ScreenHeader(
                title: "Персонажи",
                trailingButtons: [
                    AnyView(
                        Button {
                            showingFavoritesSheet = true
                        } label: {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    ),
                    AnyView(
                        Button {
                            showingFilterSheet = true
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    )
                ]
            )
        }
        .padding(.horizontal)
        .background(.bg)
    }
}
