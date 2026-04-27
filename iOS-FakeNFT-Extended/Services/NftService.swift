
import Foundation

protocol NftService: Sendable  {
    func getNfts(nftIds: [String]) async throws -> [Nft]
    
    func saveLikes(likes: [String]) async throws -> [String]
}
