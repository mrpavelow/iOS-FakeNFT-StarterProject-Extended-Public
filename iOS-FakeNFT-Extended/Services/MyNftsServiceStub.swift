import Foundation

struct MyNftsServiceStub: MyNftsService {
    let nfts: [Nft]
    
    func getMyNfts(nftIds: [String]) async throws -> [Nft] {
        return nfts
    }
}
