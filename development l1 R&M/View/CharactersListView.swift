//  Created by Emilio

import SwiftUI

struct CharactersListView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVStack(alignment: .leading, spacing: 15) {
                
                ForEach(vm.character, id: \.self) { character in
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        ZStack(alignment: .leading){
                            
                            HStack{
                                
                                AsyncImage(url: URL(string: character.image ?? ""), scale: 2.7) { image in
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
                                
                                HStack(spacing: 5){
                                    
                                    VStack(alignment: .trailing, spacing: 5){
                                        Text("Name:")
                                        Text("Species:")
                                        Text("Gender:")
                                        Text("Status:")
                                    }
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.secondary)
                                    
                                    VStack(alignment: .leading, spacing: 5){
                                        Text(character.name ?? "")
                                        Text(character.species ?? "")
                                        Text(character.gender ?? "")
                                        Text(character.status ?? "")
                                    }
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.colortext)
                                    .shadow(radius: 1)
                                }
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
            }
            .padding()
            .onAppear {
                vm.getCharacter()
            }
        }
        .background(.bg)
    }
}

#Preview {
    HomeView()
}
