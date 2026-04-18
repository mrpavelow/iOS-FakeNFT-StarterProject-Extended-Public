//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by   Дмитрий Кривенко on 10.04.2026.
//
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
                    if #available(iOS 26.0, *) {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .sharedBackgroundVisibility(.hidden)
                    } else {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
                .toolbarBackground(.hidden)
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
                    HStack() {
                        Spacer()
                    }
                    HStack() {
                        if let avatarURL = viewModel.profile?.avatar {
                            AsyncImage(url: URL(string: avatarURL.relativePath)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70, alignment: .center)
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
                        Text(viewModel.profile?.website?.relativePath ?? "")
                            .font(.caption1)
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                        .frame(height: 40)
                    navigationButton(title: "Мои NFT", count: viewModel.profile?.nfts.count ?? 0)
                    navigationButton(title: "Избранные", count: viewModel.profile?.likes.count ?? 0)
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
                    .frame(width: 70, height: 70, alignment: .center)
            )
            .frame(width: 70, height: 70, alignment: .center)
    }
    
    @ViewBuilder
    func navigationButton(title: String, count: Int) -> some View {
        NavigationLink {
            
        } label: {
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
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            profileService: ProfileServiceStub(result: .success(Profile.getMock()))
        )
    )
}
