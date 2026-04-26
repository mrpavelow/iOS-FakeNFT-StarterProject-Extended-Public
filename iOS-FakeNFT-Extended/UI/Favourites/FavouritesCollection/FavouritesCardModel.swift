import Foundation

struct FavouritesCardModel: Identifiable, Hashable {
    let id: String
    let name: String
    let imageURL: URL?
    let rating: Int
    let price: Float
    var isLiked: Bool
}
