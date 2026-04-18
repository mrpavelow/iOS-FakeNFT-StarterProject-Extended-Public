import SwiftUI

struct CollectionNftCardView: View {
    let model: CollectionNftCardModel
    let onLikeTap: () -> Void
    let onCartTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: model.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                }
                .frame(height: 121)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button(action: onLikeTap) {
                    Image(systemName: model.isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 18))
                        .foregroundStyle(model.isLiked ? .red : .white)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.15))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= model.rating ? "star.fill" : "star")
                        .font(.system(size: 10))
                        .foregroundStyle(index <= model.rating ? .yellow : Color(.systemGray4))
                }
            }
            
            Text(model.name)
                .font(.headline4)
                .foregroundStyle(Color(.textPrimary))
                .lineLimit(1)
            
            HStack(alignment: .center) {
                Text(model.priceText)
                    .font(.caption1)
                    .foregroundStyle(Color(.textPrimary))
                
                Spacer(minLength: 8)
                
                Button(action: onCartTap) {
                    Image(systemName: model.isInCart ? "xmark.square" : "bag")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(.label))
                        .frame(width: 16, height: 19)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    CollectionNftCardView(
        model: CollectionNftCardModel(
            id: "1",
            name: "Archie",
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Biscuit/1.png"),
            rating: 3,
            priceText: "1 ETH",
            isLiked: true,
            isInCart: false
        ),
        onLikeTap: {},
        onCartTap: {}
    )
    .padding()
    .background(Color(.systemBackground))
}
