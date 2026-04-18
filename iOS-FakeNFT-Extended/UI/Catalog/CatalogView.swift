import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel: CatalogViewModel
    @State private var isSortDialogPresented = false
    
    private let nftService: NftService
    
    init(viewModel: CatalogViewModel, nftService: NftService) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nftService = nftService
    }
    
    var body: some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isSortDialogPresented = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
                .confirmationDialog(
                    "Сортировка",
                    isPresented: $isSortDialogPresented,
                    titleVisibility: .visible
                ) {
                    Button("По названию") {
                        viewModel.setSort(.byName)
                    }
                    
                    Button("По количеству NFT") {
                        viewModel.setSort(.byCount)
                    }
                    
                    Button("Закрыть", role: .cancel) { }
                }
        }
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.loadCollections()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .failed(let message):
            VStack(spacing: 12) {
                Text(message)
                    .font(.bodyRegular)
                
                Button("Повторить") {
                    viewModel.loadCollections()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded:
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.sortedCollections) { collection in
                        NavigationLink {
                            CollectionView(
                                viewModel: CollectionViewModel(
                                    collection: collection,
                                    nftService: nftService
                                )
                            )
                        } label: {
                            CatalogCollectionCardView(model: collection)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
    }
}
