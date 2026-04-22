import Foundation

struct CatalogServiceStub: CatalogService {
    let result: Result<[NftCollection], Error>
    
    func loadCollections() async throws -> [NftCollection] {
        try result.get()
    }
}
