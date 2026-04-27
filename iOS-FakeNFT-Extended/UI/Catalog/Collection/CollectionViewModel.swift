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
    private let profileService: ProfileService
    private var loadedNfts: [Nft] = []
    private var likedNftIds: [String] = []
    
    init(collection: NftCollection, nftService: NftService, profileService: ProfileService) {
        self.collection = collection
        self.nftService = nftService
        self.profileService = profileService
    }
    
    func loadProfile() {
        Task {
            do {
                let profile = try await profileService.loadProfile()
                likedNftIds = profile.likes
                items = items.map {
                    var item = $0
                    item.isLiked = likedNftIds.contains($0.id) ? true : false
                    
                    return item
                }
            } catch { print("Не удалось загрузить профиль") }
        }
        
        return
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
                        isLiked: likedNftIds.contains(nft.id),
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
        guard case .loading = state else {
            Task {
                do {
                    guard let index = items.firstIndex(where: { $0.id == id }) else { return }
                    items[index].isLiked.toggle()
                    
                    let newLikedNftIds: [String] = items.filter { $0.isLiked }.map { $0.id }
                    
                    likedNftIds = try await nftService.saveLikes(likes: newLikedNftIds)
                } catch {
                    state = .failed("Не удалось загрузить ваши NFT")
                }
            }
            
            return
        }
        
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isLiked.toggle()
    }
    
    func toggleCart(for id: String) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isInCart.toggle()
    }
    
    private func loadNfts(ids: [String]) async throws -> [Nft] {
        var seen = Set<String>()
        let uniqueIds = ids.filter { seen.insert($0).inserted }
        
        
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
