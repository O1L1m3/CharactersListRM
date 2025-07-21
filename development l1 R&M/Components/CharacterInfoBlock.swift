//  Created by Emilio

import SwiftUI

struct CharacterInfoBlock: View {
    let imageUrl: String
    let imageSize: CGSize
    let imageCornerRadius: CGFloat
    let labelAlignment: HorizontalAlignment
    let labelFrameAlignment: Alignment
    let details: [(String, String)]

    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "icloud.and.arrow.down.fill")
                    .resizable()
                    .frame(width: imageSize.width / 3, height: imageSize.height / 3)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .frame(width: imageSize.width, height: imageSize.height)
            .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))

            VStack(alignment: .leading, spacing: 5) {
                ForEach(details, id: \.0) { label, value in
                    HStack(alignment: .top, spacing: 5) {
                        Text(label)
                            .font(.system(size: 14, weight: .regular))
                            .frame(width: 60, alignment: labelFrameAlignment)

                        Text(value)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(nil)
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
}
