import Foundation

struct CatalogCollection: Identifiable {
    let id = UUID()
    let title: String
    let count: Int
    let imageName: String
}
