import Foundation

protocol CatalogService: Sendable {
    func loadCollections() async throws -> [NftCollection]
}
