import Foundation

final class CatalogServiceImpl: CatalogService {
    private let networkClient: NetworkClient
    private let callbackQueue: DispatchQueue
    
    init(
        networkClient: NetworkClient,
        callbackQueue: DispatchQueue = .main
    ) {
        self.networkClient = networkClient
        self.callbackQueue = callbackQueue
    }
    
    func loadCollections(completion: @escaping (Result<[NftCollection], Error>) -> Void) {
        Task {
            do {
                let request = CollectionsRequest()
                let collections: [NftCollection] = try await networkClient.send(request: request)
                callbackQueue.async {
                    completion(.success(collections))
                }
            } catch {
                callbackQueue.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
