//  Created by Emilio

import SwiftUI

struct CharactersListHeader: View {
    
    @Binding var showingFilterSheet: Bool
    
    var body: some View {
        HStack {
            Text("Characters")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            Button("Filters") {
                showingFilterSheet = true
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .padding()
        .background(.bg)
    }
}
