
import Foundation

actor MyNftsServiceImp: MyNftsService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getMyNfts(nftIds: [String]) async throws -> [Nft] {
        return try await withThrowingTaskGroup(of: Nft.self) { group in
                for nftId in nftIds {
                    group.addTask {
                        let request = NFTRequest(id: nftId)
                        let nft: Nft = try await self.networkClient.send(request: request)
                        
                        return nft
                    }
                }
                
                var nfts = [Nft]()
                for try await nft in group {
                    nfts.append(nft)
                }
            
                return nfts
            }
    }
}
