import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            ProfileEditView(
                                viewModel: ProfileEditViewModel(
                                    profileService: ProfileServiceStub(profile: MockData.mockProfile), profile: MockData.mockProfile)
                            )
                            .navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
        }
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.loadProfile()
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
                    viewModel.loadProfile()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    HStack {
                        if let avatarURL = viewModel.profile?.avatar {
                            AsyncImage(url: URL(string: avatarURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            } placeholder: {
                                avatarPlaceholder
                            }
                        } else {
                            avatarPlaceholder
                        }
                        Spacer()
                            .frame(width: 16)
                        Text(viewModel.profile?.name ?? "")
                            .font(.headline3)
                    }
                    Spacer().frame(height: 20)
                    Text(viewModel.profile?.description ?? "")
                        .font(.caption2)
                    Spacer().frame(height: 8)
                    NavigationLink {
                        
                    } label: {
                        Text(viewModel.profile?.website ?? "")
                            .font(.caption1)
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                        .frame(height: 40)
                    NavigationLink {
                        
                    } label: {
                        navigationButtonLabel(title: "Мои NFT", count: viewModel.profile?.nfts.count ?? 0)
                    }
                    .buttonStyle(.plain)
                    NavigationLink {
                        FavouritesView(viewModel: FavouritesViewModel(
                            favouritesService: FavouritesServiceStub(nfts: MockData.mockNfts), likes: []))
                    } label: {
                        navigationButtonLabel(title: "Избранные", count: viewModel.profile?.likes.count ?? 0)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(.white)
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
    
    @ViewBuilder
    func navigationButtonLabel(title: String, count: Int) -> some View {
        HStack {
            Text(title)
                .font(.bodyBold)
            Spacer()
                .frame(width: 8)
            Text("(\(count))")
                .font(.bodyBold)
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            profileService: ProfileServiceStub(profile: MockData.mockProfile)
        )
    )
}
