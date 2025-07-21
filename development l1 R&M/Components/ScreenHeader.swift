//  Created by Emilio

import SwiftUI

struct ScreenHeader: View {
    let title: String
    let trailingButtons: [AnyView]

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()

            ForEach(trailingButtons.indices, id: \.self) { index in
                trailingButtons[index]
            }
        }
        .padding()
        .background(.bg)
    }
}
