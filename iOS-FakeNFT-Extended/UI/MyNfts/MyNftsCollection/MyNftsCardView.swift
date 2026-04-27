import SwiftUI

struct MyNftsCardView: View {
    let model: MyNftsCardModel
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
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Button(action: onLikeTap) {
                    Image(model.isLiked ? .heart : .heartBlank)
                        .frame(width: 40, height: 40)
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
                    Text("от")
                        .font(.caption1)
                        .foregroundStyle(Color(.textPrimary))
                    Text(model.author)
                        .font(.caption1)
                        .foregroundStyle(Color(.textPrimary))
                    Spacer(minLength: 8)
                }
            }
            Spacer()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Цена")
                            .font(.caption1)
                            .foregroundStyle(Color(.textPrimary))
                        Text("\(String(format: "%.2f", model.price)) ETH")
                            .font(.headline4)
                            .foregroundStyle(Color(.textPrimary))
                    }
                }
            }
            
        }
        .frame(height: 140)
    }
}

#Preview {
    MyNftsCardView(
        model: MyNftsCardModel(
            id: "1",
            name: "Archie",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Biscuit/1.png"),
            rating: 3,
            price: 1.40,
            author: "Автор",
            isLiked: true,
        ),
        onLikeTap: {},
    )
    .padding()
    .background(Color(.systemBackground))
}
