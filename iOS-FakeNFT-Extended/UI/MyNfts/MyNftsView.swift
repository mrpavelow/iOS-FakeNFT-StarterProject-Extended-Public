import SwiftUI

struct MyNftsView: View {
    @StateObject private var viewModel: MyNftsViewModel
    @Environment(\.dismiss) var dismiss
    @AppStorage("myNftsOrderBy") private var myNftsOrderBy = OrderBy.name.rawValue
    
    init(viewModel: MyNftsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.showOrderMenu = true
                        } label: {
                            Image(systemName: "line.horizontal.3")
                            
                        }
                        .confirmationDialog("Сортировка", isPresented: $viewModel.showOrderMenu, titleVisibility: .hidden) {
                            Button("По имени") {
                                viewModel.orderBy = .name
                                viewModel.showOrderMenu = false
                                myNftsOrderBy = OrderBy.name.rawValue
                            }
                            Button("По цене") {
                                viewModel.orderBy = .price
                                viewModel.showOrderMenu = false
                                myNftsOrderBy = OrderBy.price.rawValue
                            }
                            Button("По рейтингу") {
                                viewModel.orderBy = .rating
                                viewModel.showOrderMenu = false
                                myNftsOrderBy = OrderBy.rating.rawValue
                            }
                        }
                    }
                }
        }
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.getMyNfts()
            }
            viewModel.orderBy = OrderBy(rawValue: myNftsOrderBy) ?? .name
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
                    viewModel.getMyNfts()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            if (viewModel.myNfts.count > 0) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.myNfts) { item in
                            MyNftsCardView(
                                model: item
                            )
                        }
                    }
                    .animation(.default, value: viewModel.myNfts)
                }
                .padding(.horizontal)
                .background(.white)
                .scrollIndicators(.hidden)
            } else {
                Text("У Вас ещё нет NFT")
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
    MyNftsView(
        viewModel: MyNftsViewModel(
            myNftsService: MyNftsServiceStub(nfts: MockData.mockNfts), myNftIds: [])
    )
}


