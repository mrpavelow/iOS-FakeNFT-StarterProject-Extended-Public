import Foundation

struct CollectionNftCardModel: Identifiable, Hashable {
    let id: String
    let name: String
    let imageURL: URL?
    let rating: Int
    let priceText: String
    var isLiked: Bool
    var isInCart: Bool
}
