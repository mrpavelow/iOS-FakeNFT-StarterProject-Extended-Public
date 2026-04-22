import Foundation

protocol FavouritesService: Sendable  {
    func getFavourites(likes: [String]) async throws -> [Nft]
}
