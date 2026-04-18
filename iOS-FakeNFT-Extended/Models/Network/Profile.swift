import Foundation

struct Profile: Decodable {
    let name: String
    let avatar: URL?
    let description: String
    let website: URL?
    let nfts: [String]
    let likes: [String]
    let id: String
    
    static func getMock() -> Profile {
        return Profile(name: "Студентус Практикумус",
                       avatar: URL("https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG")!,
                       description: "Прошел 5-й спринт, и этот пройду",
                       website: URL("https://practicum.yandex.ru/ios-developer")!,
                       nfts: ["1", "2", "3"],
                       likes: ["1", "4", "8"],
                       id: "1")
    }
}
