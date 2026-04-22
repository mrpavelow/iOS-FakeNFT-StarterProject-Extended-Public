import SwiftUI

struct CollectionHeaderView: View {
    let collection: NftCollection
    let authorURL: URL?
    let onAuthorTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            coverView
            VStack(alignment: .leading, spacing: 16) {
                Text(collection.name)
                    .font(.headline3)
                    .foregroundStyle(Color(.textPrimary))
                
                HStack(spacing: 4) {
                    Text("Автор коллекции:")
                        .font(.caption1)
                        .foregroundStyle(Color(.textPrimary))
                    
                    if authorURL != nil {
                        Button(action: onAuthorTap) {
                            Text(collection.author)
                                .font(.caption1)
                                .foregroundStyle(Color(.blue))
                        }
                        .buttonStyle(.plain)
                    } else {
                        Text(collection.author)
                            .font(.caption1)
                            .foregroundStyle(Color.blue)
                    }
                }
                
                if let description = collection.description, !description.isEmpty {
                    Text(description)
                        .font(.caption1)
                        .foregroundStyle(Color(.textPrimary))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    private var coverView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
            
            AsyncImage(url: collection.cover) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                    
                @unknown default:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                }
            }
        }
        .frame(height: 310)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, -16)
    }
}


#Preview {
    CollectionHeaderView(
        collection: NftCollection(
            id: "1",
            name: "Peach",
            cover: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png")!,
            nfts: ["1", "2"],
            description: "Персиковый — как облака над закатным солнцем...",
            author: "John Doe"
        ),
        authorURL: URL(string: "https://apple.com"),
        onAuthorTap: {},
    )
    .padding()
}
