import Foundation
import Combine

final class CatalogViewModel: ObservableObject {
    
    enum SortOption: String, CaseIterable, Identifiable {
        case byName
        case byCount
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .byName: "По названию"
            case .byCount: "По количеству NFT"
            }
        }
    }
    
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let catalogService: CatalogService
    
    @Published private(set) var state: State = .idle
    @Published private(set) var collections: [NftCollection] = []
    @Published private(set) var selectedSort: SortOption = .byCount
    
    init(catalogService: CatalogService) {
        self.catalogService = catalogService
    }
    
    var sortedCollections: [NftCollection] {
        switch selectedSort {
        case .byName:
            return collections.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        case .byCount:
            return collections.sorted {
                if $0.nfts.count == $1.nfts.count {
                    return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
                }
                return $0.nfts.count > $1.nfts.count
            }
        }
    }
    
    func loadCollections() {
        guard case .loading = state else {
            state = .loading
            
            catalogService.loadCollections { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let collections):
                    self.collections = collections
                    self.state = .loaded
                case .failure:
                    self.state = .failed("Не удалось загрузить коллекции")
                }
            }
            
            return
        }
    }
    
    func setSort(_ option: SortOption) {
        selectedSort = option
    }
}
