import SwiftUI

struct CatalogCollectionCardView: View {
    let model: NftCollection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: model.cover) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color(.secondarySystemBackground))
            }
            .frame(height: 140)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text("\(model.name) (\(model.nfts.count))")
                .font(.bodyBold)
                .foregroundStyle(Color(.textPrimary))
        }
    }
}

private extension NftCollection {
    static let preview = NftCollection(
        id: "1",
        name: "Peach",
        cover: URL(string: "https://picsum.photos/400/240")!,
        nfts: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"],
        description: "Test description",
        author: "John Doe"
    )
}

#Preview {
    CatalogCollectionCardView(model: .preview)
        .padding(.horizontal, 16)
}
