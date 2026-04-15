import Foundation

struct NftCollection: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let coverUrl: URL
    let nfts: [String]
    let description: String?
    let author: String
}
