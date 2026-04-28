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
                    Image(model.isLiked ? .heart : .heartBlank)
                        .frame(width: 40, height: 40)
                }
            }
            
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(index <= model.rating ? .stars : .starsBlank)
                        .font(.system(size: 10))
                        .foregroundStyle(index <= model.rating ? .yellow : Color(.systemGray4))
                }
            }
            
            Text(model.name)
                .font(.bodyBold)
                .foregroundStyle(Color(.textPrimary))
                .lineLimit(1)
            
            HStack {
                Text(model.priceText)
                    .font(.price1)
                    .foregroundStyle(Color(.textPrimary))
                
                Spacer()
                
                Button(action: onCartTap) {
                    Image(model.isInCart ? .cartX : .cart)
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
