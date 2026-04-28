import Foundation

@Observable
@MainActor
final class ServicesAssembly {
    
    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    
    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }
    
    var nftService: NftService {
        NftServiceImp(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var profileService: ProfileService {
        ProfileServiceImp(
            networkClient: networkClient,
        )
    }
    
    var catalogService: CatalogService {
        CatalogServiceImpl(networkClient: networkClient)
    }
}
