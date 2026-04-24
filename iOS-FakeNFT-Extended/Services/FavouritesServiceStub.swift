import Foundation

struct FavouritesServiceStub: FavouritesService {
    let nfts: [Nft]
    
    func getFavourites(likes: [String]) async throws -> [Nft] {
        return nfts
    }
}

