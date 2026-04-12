import Foundation

struct CatalogServiceStub: CatalogService {
    let result: Result<[NftCollection], Error>
    
    func loadCollections(completion: @escaping (Result<[NftCollection], Error>) -> Void) {
        completion(result)
    }
}
