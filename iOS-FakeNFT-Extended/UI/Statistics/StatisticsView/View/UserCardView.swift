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
                headerView
                descriptionView
                actionButton
                collectionLink
                Spacer()
            }
            .padding(24)
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerView: some View {
        HStack(spacing: 12) {
            Image(systemName: user.avatarSystemName ?? "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(.secondary)
            
            Text(user.name)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
        }
    }
    
    private var descriptionView: some View {
        Text("Дизайнер из Казани, люблю цифровое искусство  и бейглы. В моей коллекции уже 100+ NFT,  и еще больше — на моём сайте. Открыт  к коллаборациям.")
            .font(.system(size: 13))
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var actionButton: some View {
        Button {
            if URL(string: "https://example.com") != nil {
            }
        } label: {
            Text("Перейти на сайт пользователя")
                .font(.system(size: 17, weight: .regular))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary, lineWidth: 1)
        )
        .foregroundStyle(.primary)
    }
    
    private var collectionLink: some View {
        NavigationLink {
            UserCollectionView(title: "Коллекция NFT", count: user.score)
        } label: {
            HStack {
                Text("Коллекция NFT (\(user.score))")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(Color.white)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let sampleUser = StatisticsUser(
        id: "1",
        name: "Joaquin Phoenix",
        score: 112,
        avatarSystemName: "person.crop.circle.fill"
    )
    NavigationStack {
        UserCardView(user: sampleUser)
    }
}
