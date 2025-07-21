//  Created by Emilio

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterRM
    let favoritesManager: FavoritesManager
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: CharacterDetailViewModel
    @StateObject private var episodeLoader = EpisodeLoader()
    @State private var isImageFullScreenPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(
                title: "О персонаже",
                trailingButtons: [
                    AnyView(
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    )
                ]
            )
            .padding(.horizontal)
            .background(.bg)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center, spacing: 8) {
                        Text(character.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        FavoriteButton(character: character, favoritesManager: favoritesManager)
                    }
                    
                    Button {
                        isImageFullScreenPresented = true
                    } label: {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "icloud.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        
                        CharacterInfoBlock(
                            imageUrl: "",
                            imageSize: .zero,
                            imageCornerRadius: 0,
                            labelAlignment: .leading,
                            labelFrameAlignment: .leading,
                            details: [
                                ("Вид:", viewModel.localizedSpecies),
                                ("Гендер:", viewModel.localizedGender),
                                ("Статус:", viewModel.localizedStatus)
                            ]
                        )
                    }
                    .padding(.bottom)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.num1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Эпизоды:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            if episodeLoader.episodes.isEmpty {
                                ProgressView("Загрузка эпизодов...")
                            } else {
                                ForEach(episodeLoader.episodes) { episode in
                                    Text("• \(episode.name)")
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.num1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                .background(.bg)
            }
            .background(.bg)
            .onAppear {
                Task {
                    await episodeLoader.loadEpisodes(from: character.episode)
                }
            }
        }
        .fullScreenCover(isPresented: $isImageFullScreenPresented) {
            ZStack {
                Color.bg.ignoresSafeArea()
                
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isImageFullScreenPresented = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
            }
        }
    }
}
