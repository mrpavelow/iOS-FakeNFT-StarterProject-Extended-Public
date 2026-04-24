import Foundation
import Combine

@MainActor
final class MyNftsViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    enum OrderBy {
        case name
        case price
        case rating
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
    
    private let myNftsService: MyNftsService
    private var myNftIds: [String]
    
    @Published private(set) var state: State = .idle
    @Published private(set) var myNfts: [MyNftsCardModel] = []
    @Published var showOrderMenu: Bool = false
    
    
    init(myNftsService: MyNftsService, myNftIds: [String]) {
        self.myNftsService = myNftsService
        self.myNftIds = myNftIds
    }
    
    func getMyNfts() {
        guard case .loading = state else {
            Task {
                do {
                    let nfts = try await myNftsService.getMyNfts(nftIds: myNftIds)
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
                                   author: nft.author ?? "")
        }
    }
}
