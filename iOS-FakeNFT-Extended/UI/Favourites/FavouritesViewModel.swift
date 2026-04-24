import Foundation
import Combine

@MainActor
final class FavouritesViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let favouritesService: FavouritesService
    private let likes: [String]
    
    @Published private(set) var state: State = .idle
    @Published private(set) var favourites: [FavouritesCardModel] = []
    
    init(favouritesService: FavouritesService, likes: [String]) {
        self.favouritesService = favouritesService
        self.likes = likes
    }
    
    func getFavourites() {
        guard case .loading = state else {
            Task {
                do {
                    let nfts = try await favouritesService.getFavourites(likes: likes)
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
                                       price: nft.price
            )
        }
    }
}
