import SwiftUI

struct CollectionView: View {
    let collection: NftCollection
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: collection.coverUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(height: 200)
                .clipped()
                
                Text(collection.name)
                    .font(.bodyBold)
                
                if let description = collection.description {
                    Text(description)
                        .font(.bodyRegular)
                        .foregroundStyle(.secondary)
                }
                
                Text("Автор: \(collection.author)")
                    .font(.caption1)
                    .foregroundStyle(.secondary)
            // TODO: Тут позже будет UICollectionView (пока заглушка)
                Text("NFT список будет тут")
                    .padding(.top, 16)
                
            }
            .padding(16)
        }
        .navigationTitle("Коллекция")
        .navigationBarTitleDisplayMode(.inline)
    }
}
