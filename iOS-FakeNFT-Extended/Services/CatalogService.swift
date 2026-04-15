import Foundation

protocol CatalogService {
    func loadCollections(completion: @escaping (Result<[NftCollection], Error>) -> Void)
}
