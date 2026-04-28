
import Foundation

actor NftServiceImp: NftService {
    private let networkClient: NetworkClient
    private let storage: NftStorage
    
    init(networkClient: NetworkClient, storage: NftStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }

    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
    
    func getNfts(nftIds: [String]) async throws -> [Nft] {
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
    
    func saveLikes(likes: [String]) async throws -> [String] {
        let request = SaveProfileRequest(parameters: ["likes": likes.count > 0 ? likes : "null"])
        
        let profile: Profile = try await networkClient.send(request: request)
        
        return profile.likes
    }
}
