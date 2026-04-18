import SwiftUI

struct CollectionView: View {
    @StateObject private var viewModel: CollectionViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isAuthorWebViewPresented = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 9),
        GridItem(.flexible(), spacing: 9),
        GridItem(.flexible(), spacing: 9)
    ]
    
    init(viewModel: CollectionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CollectionHeaderView(
                    collection: viewModel.collection,
                    authorURL: viewModel.authorURL,
                    onAuthorTap: {
                        guard viewModel.authorURL != nil else { return }
                        isAuthorWebViewPresented = true
                    },
                )
                
                content
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        .task {
            viewModel.loadIfNeeded()
        }
        .sheet(isPresented: $isAuthorWebViewPresented) {
            if let url = viewModel.authorURL {
                NavigationStack {
                    AuthorWebView(url: url)
                        .ignoresSafeArea(edges: .bottom)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Закрыть") {
                                    isAuthorWebViewPresented = false
                                }
                            }
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            VStack {
                ProgressView()
                    .padding(.top, 24)
            }
            .frame(maxWidth: .infinity)
            
        case .failed(let message):
            VStack(spacing: 12) {
                Text(message)
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
                
                Button("Повторить") {
                    viewModel.load()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 24)
            
        case .loaded:
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(viewModel.items) { item in
                    CollectionNftCardView(
                        model: item,
                        onLikeTap: {
                            viewModel.toggleLike(for: item.id)
                        },
                        onCartTap: {
                            viewModel.toggleCart(for: item.id)
                        }
                    )
                }
            }
        }
    }
}
