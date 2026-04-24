import Foundation

struct MyNftsCardModel: Identifiable, Hashable {
    let id: String
    let name: String
    let imageURL: URL?
    let rating: Int
    let price: Float
    let author: String
}
