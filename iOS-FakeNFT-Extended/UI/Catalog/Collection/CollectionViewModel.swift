import SwiftUI

@MainActor
final class CollectionViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    @Published private(set) var state: State = .idle
    @Published private(set) var items: [CollectionNftCardModel] = []
    
    let collection: NftCollection
    
    var authorURL: URL? {
        guard
            let firstWebsite = loadedNfts.compactMap(\.website).first,
            let url = URL(string: firstWebsite)
        else {
            return nil
        }
        
        return url
    }
    
    private let nftService: NftService
    private var loadedNfts: [Nft] = []
    
    init(collection: NftCollection, nftService: NftService) {
        self.collection = collection
        self.nftService = nftService
    }
    
    func loadIfNeeded() {
        guard case .idle = state else { return }
        load()
    }
    
    func load() {
        state = .loading
        
        Task {
            do {
                let nfts = try await loadNfts(ids: collection.nfts)
                loadedNfts = nfts
                items = nfts.map { nft in
                    CollectionNftCardModel(
                        id: nft.id,
                        name: nft.name,
                        imageURL: nft.images.first,
                        rating: nft.rating,
                        priceText: priceText(from: nft.price),
                        isLiked: false,
                        isInCart: false
                    )
                }
                state = .loaded
            } catch {
                state = .failed("Не удалось загрузить NFT")
            }
        }
    }
    
    func toggleLike(for id: String) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isLiked.toggle()
    }
    
    func toggleCart(for id: String) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isInCart.toggle()
    }
    
    private func loadNfts(ids: [String]) async throws -> [Nft] {
        var uniqueIds: [String] = []
        var seen = Set<String>()
        
        for id in ids {
            if seen.insert(id).inserted {
                uniqueIds.append(id)
            }
        }
        
        return try await withThrowingTaskGroup(of: Nft.self) { group in
            for id in uniqueIds {
                group.addTask { [nftService] in
                    try await nftService.loadNft(id: id)
                }
            }
            
            var result: [Nft] = []
            for try await nft in group {
                result.append(nft)
            }
            
            let orderMap = Dictionary(
                uniqueKeysWithValues: uniqueIds.enumerated().map { ($1, $0) }
            )
            
            return result.sorted {
                (orderMap[$0.id] ?? .max) < (orderMap[$1.id] ?? .max)
            }
        }
    }
    
    private func priceText(from price: Float) -> String {
        let intPrice = Int(price)
        if Float(intPrice) == price {
            return "\(intPrice) ETH"
        } else {
            return "\(price) ETH"
        }
    }
}
