import Foundation

@MainActor
final class MyNftsViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    var orderBy: OrderBy = .name {
        didSet {
            switch orderBy {
            case .name:
                myNfts = myNfts.sorted { $0.name < $1.name }
            case .price:
                myNfts = myNfts.sorted { $0.price < $1.price }
            case .rating:
                myNfts = myNfts.sorted { $0.rating < $1.rating }
            }
        }
    }
    
    private let nftService: NftService
    private var myNftIds: [String]
    private var likedNftIds: [String] = []
    
    @Published private(set) var state: State = .idle
    @Published private(set) var myNfts: [MyNftsCardModel] = []
    @Published var showOrderMenu: Bool = false
    
    init(nftService: NftService, myNftIds: [String], likedNftIds: [String]) {
        self.nftService = nftService
        self.myNftIds = myNftIds
        self.likedNftIds = likedNftIds
    }
    
    func getMyNfts() {
        guard case .loading = state else {
            Task {
                do {
                    let nfts = try await nftService.getNfts(nftIds: myNftIds)
                    state = .loaded
                    setMyNfts(nfts: nfts)
                } catch {
                    state = .failed("Не удалось загрузить ваши NFT")
                }
            }
            
            return
        }
    }
    
    func setMyNfts(nfts: [Nft]) {
        myNfts = nfts.map { (nft) in
            let imageURL = nft.images.count > 0 ? nft.images[0] : nil
            
            return MyNftsCardModel(id: nft.id,
                                   name: nft.name,
                                   imageURL: imageURL,
                                   rating: nft.rating,
                                   price: nft.price,
                                   author: nft.author ?? "",
                                   isLiked: likedNftIds.contains(nft.id))
        }
    }
    
    func toggleLike(for id: String) {
        guard case .loading = state else {
            Task {
                do {
                    guard let index = myNfts.firstIndex(where: { $0.id == id }) else { return }
                    myNfts[index].isLiked.toggle()
                    
                    let newLikedNftIds: [String] = myNfts.filter { $0.isLiked }.map { $0.id }
                    
                    likedNftIds = try await nftService.saveLikes(likes: newLikedNftIds)
                } catch {
                    state = .failed("Не удалось загрузить ваши NFT")
                }
            }
            
            return
        }
    }
}

enum OrderBy: String {
    case name
    case price
    case rating
}
