import SwiftUI

struct FavouritesView: View {
    @StateObject private var viewModel: FavouritesViewModel
    @Environment(\.dismiss) var dismiss
    
    private let columns = [
        GridItem(.flexible(), spacing: 7, alignment: .top),
        GridItem(.flexible(), spacing: 7, alignment: .top),
    ]
    
    init(viewModel: FavouritesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
        }
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.getFavourites()
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
                    viewModel.getFavourites()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
                if (viewModel.favourites.count > 0) {
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .trailing, spacing: 16) {
                            ForEach(viewModel.favourites) { item in
                                FavouritesCardView(
                                    model: item
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(.white)
                    .scrollIndicators(.hidden)
                } else {
                    Text("У Вас ещё нет избранных NFT")
                        .font(.bodyBold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
        }
    }
    
    @ViewBuilder
    private var avatarPlaceholder: some View {
        Image(systemName: "person.crop.circle.fill")
            .background(
                Circle()
                    .frame(width: 70, height: 70)
            )
            .frame(width: 70, height: 70)
    }
}

#Preview {
    FavouritesView(
        viewModel: FavouritesViewModel(
            favouritesService: FavouritesServiceStub(nfts: MockData.mockNfts), likes: [])
    )
}

