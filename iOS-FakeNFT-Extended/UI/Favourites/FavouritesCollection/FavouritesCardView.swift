import SwiftUI

struct FavouritesCardView: View {
    let model: FavouritesCardModel
    let onLikeTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: model.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Button(action: onLikeTap) {
                    Image(model.isLiked ? .heart : .heartBlank)
                        .frame(width: 40, height: 40)
                        .offset(x: 5, y: -5)
                }
            }
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.headline4)
                    .foregroundStyle(Color(.textPrimary))
                    .lineLimit(1)
                Spacer().frame(height: 4)
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { index in
                        Image(index <= model.rating ? .star : .starBlank)
                            .frame(width: 12, height: 12)
                    }
                }
                Spacer().frame(height: 8)
                HStack {
                    Text("\(String(format: "%.2f", model.price)) ETH")
                        .font(.caption1)
                        .foregroundStyle(Color(.textPrimary))
                    
                    Spacer(minLength: 8)
                }
            }
        }
        .frame(height: 80)
    }
}

#Preview {
    FavouritesCardView(
        model: FavouritesCardModel(
            id: "1",
            name: "Archie",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Biscuit/1.png"),
            rating: 3,
            price: 1,
            isLiked: true,
        ),
        onLikeTap: {}
    )
    .padding()
    .background(Color(.systemBackground))
}
