import Foundation

struct NftServiceStub: NftService {
    func loadNft(id: String) async throws -> Nft {
        MockData.mockNft()
    }
    
    
    let nfts: [Nft]
    
    func getNfts(nftIds: [String]) async throws -> [Nft] {
        return nfts
    }
    
    func saveLikes(likes: [String]) async throws -> [String] {
        return []
    }

}
