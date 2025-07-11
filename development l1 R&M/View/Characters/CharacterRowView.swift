//  Created by Emilio

import SwiftUI

struct CharacterRowView: View {
    let character: CharacterRM

    var body: some View {
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
                    
                    VStack(alignment: .leading, spacing: 3){
                        let details: [(String, String?)] = [
                            ("Name:", character.name),
                            ("Species:", character.species),
                            ("Gender:", character.gender),
                            ("Status:", character.status)
                        ]
                        
                        ForEach(details, id: \.0) { label, value in
                            HStack(alignment: .top, spacing: 5) {
                                Text(label)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.secondary)
                                    .frame(width: 75, alignment: .trailing)
                                
                                Text(value ?? "")
                                    .lineLimit(nil)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.colortext)
                                    .shadow(radius: 1)
                            }
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
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
