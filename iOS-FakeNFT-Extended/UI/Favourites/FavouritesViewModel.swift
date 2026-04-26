import Foundation

@MainActor
final class FavouritesViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let nftService: NftService
    private var likes: [String]
    
    @Published private(set) var state: State = .idle
    @Published private(set) var favourites: [FavouritesCardModel] = []
    
    init(nftService: NftService, likes: [String]) {
        self.nftService = nftService
        self.likes = likes
    }
    
    func getFavourites() {
        guard case .loading = state else {
            Task {
                do {
                    let nfts = try await nftService.getNfts(nftIds: likes)
                    state = .loaded
                    setFavourites(nfts: nfts)
                } catch {
                    state = .failed("Не удалось загрузить избранные NFT")
                }
            }
            
            return
        }
    }
    
    func setFavourites(nfts: [Nft]) {
        favourites = nfts.map { (nft) in
            let imageURL = nft.images.count > 0 ? nft.images[0] : nil
            
            return FavouritesCardModel(id: nft.id,
                                       name: nft.name,
                                       imageURL: imageURL,
                                       rating: nft.rating,
                                       price: nft.price,
                                       isLiked: true)
        }
    }
    
    func toggleLike(for id: String) {
        guard case .loading = state else {
            Task {
                do {
                    guard let index = favourites.firstIndex(where: { $0.id == id }) else { return }
                    
                    var newFafourites = favourites
                    
                    newFafourites.remove(at: index)
                    likes = try await nftService.saveLikes(likes: newFafourites.map { $0.id })
                    favourites = newFafourites
                } catch {
                    state = .failed("Не удалось удалить из избранного")
                }
            }
            
            return
        }
    }
}
