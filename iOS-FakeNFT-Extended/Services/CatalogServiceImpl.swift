import Foundation

actor CatalogServiceImpl: CatalogService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> [NftCollection] {
        let request = CollectionsRequest()
        return try await networkClient.send(request: request)
    }
}
