import Foundation

protocol NftService: Sendable  {
    func loadNft(id: String) async throws -> Nft
    
    func getNfts(nftIds: [String]) async throws -> [Nft]
    
    func saveLikes(likes: [String]) async throws -> [String]
}
