
import Foundation

protocol MyNftsService: Sendable  {
    func getMyNfts(nftIds: [String]) async throws -> [Nft]
}
