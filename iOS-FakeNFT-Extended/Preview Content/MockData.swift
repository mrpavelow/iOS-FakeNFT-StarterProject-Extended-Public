import Foundation

enum MockData {
    static let mockProfile: Profile = Profile(
        name: "Студентус Практикумус",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Прошел 5-й спринт, и этот пройду",
        website: "https://practicum.yandex.ru/ios-developer",
        nfts: ["1", "2", "3"],
        likes: ["1", "4", "8"],
        id: "1"
    )
    
    static func mockNft() -> Nft {
        return Nft(createdAt: "werwer",
                   name: "sdfsdfs sdfsdfs sdfsdfs sdfsdfs",
                   images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Biscuit/1.png")!],
                   rating: Int.random(in: 1..<6),
                   description: "dfsdfd",
                   price: Float.random(in: 1..<100),
                   author: "Author",
                   website: "https://apple.com",
                   id: "\(Int.random(in: 1..<1000))")
    }
    
    
    static let mockNfts: [Nft] = [
        MockData.mockNft(),
        MockData.mockNft(),
        MockData.mockNft(),
        MockData.mockNft(),
        MockData.mockNft(),
        MockData.mockNft(),
        MockData.mockNft()
    ]
}
