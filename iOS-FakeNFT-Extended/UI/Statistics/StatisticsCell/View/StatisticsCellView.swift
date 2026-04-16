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
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            indexView
            contentView
        }
    }
    
    // MARK: - Private Views
    
    private var indexView: some View {
        Text("\(index)")
            .font(.system(size: 15, weight: .regular))
            .foregroundStyle(.secondary)
            .frame(width: 24, alignment: .leading)
    }
    
    private var contentView: some View {
        HStack(spacing: 12) {
            avatarView
            nameView
            Spacer()
            scoreView
        }
        .padding(.horizontal, 16)
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(Color.ypLightGrayDay)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var avatarView: some View {
        Image(systemName: user.avatarSystemName ?? "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 28, height: 28)
            .foregroundStyle(.secondary)
    }
    
    private var nameView: some View {
        Text(user.name)
            .font(.headline)
    }
    
    private var scoreView: some View {
        Text("\(user.score)")
            .font(.system(size: 22, weight: .bold))
    }
}

// MARK: - Preview

#Preview {
    StatisticsCellView(
        index: 1,
        user: StatisticsUser(
            id: "1",
            name: "Алиса",
            score: 1234,
            avatarSystemName: "person.crop.circle.fill"
        )
    )
}
