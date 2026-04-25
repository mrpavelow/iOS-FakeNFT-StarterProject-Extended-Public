//
//  StatisticCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 08.04.2026.
//
import SwiftUI

struct StatisticsCellView: View {
    let index: Int
    let user: StatisticsUser
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            indexText
            userCard
        }
    }
    
    private var indexText: some View {
        Text("\(index)")
            .font(.system(size: 15))
            .foregroundStyle(.secondary)
            .frame(width: 24, alignment: .leading)
    }
    
    private var userCard: some View {
        HStack(spacing: 12) {
            userAvatar
            userNameText
            Spacer()
            userScoreText
        }
        .padding(.horizontal, 16)
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(Color.ypLightGrayDay)
        .clipShape(cardShape)
    }
    
    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 12)
    }
    
    private var userAvatar: some View {
        Group {
            if let avatarURL = user.avatarURL {
                asyncAvatar(url: avatarURL)
            } else {
                placeholderAvatar
            }
        }
        .frame(width: 28, height: 28)
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
            .font(.headline)
            .lineLimit(1)
    }
    
    private var userScoreText: some View {
        Text("\(user.score)")
            .font(.system(size: 22, weight: .bold))
    }
}

#Preview {
    let mockUser = StatisticsUser(
        id: "1",
        name: "Иван Иванов",
        score: 15,
        description: " ",
        website: "https://example.com",
        avatarURL: URL(string: "https://picsum.photos/400/400?random=1"),
        nftIds: ["1"]
    )
    return VStack {
        StatisticsCellView(index: 1, user: mockUser)
    }
    .padding()
    .background(Color.white)
}
