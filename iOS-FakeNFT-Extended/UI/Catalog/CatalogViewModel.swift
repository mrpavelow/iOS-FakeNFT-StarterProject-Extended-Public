import Foundation
import Combine

@MainActor
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
        guard case .idle = state else {
            if case .failed = state {
                reloadCollections()
            }
            return
        }
        
        state = .loading
        
        Task {
            do {
                collections = try await catalogService.loadCollections()
                state = .loaded
            } catch {
                state = .failed("Не удалось загрузить коллекции")
            }
        }
    }
    
    func reloadCollections() {
        state = .loading
        
        Task {
            do {
                collections = try await catalogService.loadCollections()
                state = .loaded
            } catch {
                state = .failed("Не удалось загрузить коллекции")
            }
        }
    }
    
    func setSort(_ option: SortOption) {
        selectedSort = option
    }
}
