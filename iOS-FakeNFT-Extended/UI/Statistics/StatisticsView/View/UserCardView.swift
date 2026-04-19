//
//  UserCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 14.04.2026.
//
import SwiftUI

struct UserCardView: View {
    
    let user: StatisticsUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                userHeaderView
                descriptionView
                websiteLinkView
                collectionNavigationView
                Spacer()
            }
            .padding(24)
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }
     
    private var userHeaderView: some View {
        HStack(spacing: 12) {
            userAvatar
            userNameText
            Spacer()
        }
    }
    
    private var userAvatar: some View {
        Group {
            if let avatarURL = user.avatarURL {
                asyncAvatar(url: avatarURL)
            } else {
                placeholderAvatar
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
    }
    
    private func asyncAvatar(url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
    }
    
    private var placeholderAvatar: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.secondary)
    }
    
    private var userNameText: some View {
        Text(user.name)
            .font(.system(size: 22, weight: .bold))
    }
       
    @ViewBuilder
    private var descriptionView: some View {
        if hasValidDescription {
            userDescriptionText
        } else {
            emptyDescriptionText
        }
    }
    
    private var hasValidDescription: Bool {
        guard let description = user.description else { return false }
        return !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var userDescriptionText: some View {
        Text(user.description ?? "")
            .font(.system(size: 13))
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var emptyDescriptionText: some View {
        Text("Описание отсутствует")
            .font(.system(size: 13))
            .foregroundStyle(.secondary)
    }
    
    @ViewBuilder
    private var websiteLinkView: some View {
        if let website = user.website,
           let url = URL(string: website),
           !website.isEmpty {
            websiteLinkButton(url: url)
        }
    }
    
    private func websiteLinkButton(url: URL) -> some View {
        Link(destination: url) {
            Text("Перейти на сайт пользователя")
                .font(.system(size: 17))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .overlay(websiteLinkBorder)
    }
    
    private var websiteLinkBorder: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.primary, lineWidth: 1)
    }
    
    // MARK: - Collection Navigation
    
    private var collectionNavigationView: some View {
        NavigationLink {
            UserCollectionView(
                title: "Коллекция NFT",
                nftIds: user.nftIds,
                service: StatisticsService(api: APIClient(baseURL: RequestConstants.baseURL))
            )
        } label: {
            collectionLabel
        }
        .buttonStyle(.plain)
    }
    
    private var collectionLabel: some View {
        HStack {
            collectionTitleText
            Spacer()
            chevronIcon
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color.white)
    }
    
    private var collectionTitleText: some View {
        Text("Коллекция NFT (\(user.score))")
            .font(.system(size: 17, weight: .bold))
    }
    
    private var chevronIcon: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    let mockUser = StatisticsUser(
        id: "1",
        name: "Иван Иванов",
        score: 15,
        description: "Описание",
        website: "https://example.com",
        avatarURL: URL(string: "https://picsum.photos/400/400?random=1"),
        nftIds: ["1", "2", "3"]
    )
    
    return NavigationStack {
        UserCardView(user: mockUser)
    }
}
