import Foundation

actor FavouritesServiceImp: FavouritesService {
    private let networkClient: NetworkClient
    
    init(
        networkClient: NetworkClient,
    ) {
        self.networkClient = networkClient
    }
    
    func getFavourites(likes: [String]) async throws -> [Nft] {
        return try await withThrowingTaskGroup(of: Nft.self) { group in
                for like in likes {
                    group.addTask {
                        let request = NFTRequest(id: like)
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

