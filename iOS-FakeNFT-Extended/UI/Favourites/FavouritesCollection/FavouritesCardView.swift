import SwiftUI

struct FavouritesCardView: View {
    let model: FavouritesCardModel
    
    var body: some View {
        HStack(spacing: 12) {
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
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.headline4)
                    .foregroundStyle(Color(.textPrimary))
                    .lineLimit(1)
                Spacer().frame(height: 4)
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= model.rating ? "star.fill" : "star")
                            .font(.system(size: 10))
                            .foregroundStyle(index <= model.rating ? .yellow : Color(.systemGray4))
                    }
                }
                Spacer().frame(height: 8)
                HStack {
                    Text("\(model.price) ETH")
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
        ),
    )
    .padding()
    .background(Color(.systemBackground))
}
