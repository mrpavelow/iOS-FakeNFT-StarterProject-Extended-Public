import Foundation

struct NftServiceStub: NftService {
    
    let nfts: [Nft]
    
    func getNfts(nftIds: [String]) async throws -> [Nft] {
        return nfts
    }
    
    func saveLikes(likes: [String]) async throws -> [String] {
        return []
    }

}
