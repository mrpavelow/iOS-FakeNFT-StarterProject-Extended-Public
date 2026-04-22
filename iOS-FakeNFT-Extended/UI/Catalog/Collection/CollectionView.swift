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
        ZStack(alignment: .topLeading) {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    CollectionHeaderView(
                        collection: viewModel.collection,
                        authorURL: viewModel.authorURL,
                        onAuthorTap: {
                            guard viewModel.authorURL != nil else { return }
                            isAuthorWebViewPresented = true
                        }
                    )
                    .padding(.horizontal, 16)
                    
                    content
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 24)
            }
            .ignoresSafeArea(edges: .top)
            .background(Color(.systemBackground))
            backButton
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.loadIfNeeded()
        }
        .fullScreenCover(isPresented: $isAuthorWebViewPresented) {
            if let url = viewModel.authorURL {
                NavigationStack {
                    AuthorWebView(url: url)
                        .ignoresSafeArea(edges: .bottom)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    isAuthorWebViewPresented = false
                                } label: {
                                    Image(systemName: "chevron.left")
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
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 40, height: 40)
                .background(Color(.systemBackground).opacity(0.9))
                .clipShape(Circle())
        }
        .padding(.leading, 16)
        .padding(.top, 16)
    }
}
