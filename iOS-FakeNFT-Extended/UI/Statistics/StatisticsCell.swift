//
//  StatisticCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 08.04.2026.
//
import SwiftUI

struct StatisticsCell: View {
    let index: Int
    let user: StatisticsUser
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            Text("\(index)")
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 24, alignment: .leading)
            
            HStack(spacing: 12) {
                Image(systemName: user.avatarSystemName ?? "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.secondary)
                
                Text(user.name)
                    .font(.headline)
                
                Spacer()
                
                Text("\(user.score)")
                    .font(.system(size: 22, weight: .bold))
                
            }
            .padding(.horizontal, 16)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.ypLightGrayDay)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    StatisticsCell(
        index: 1,
        user: StatisticsUser(
            id: "1",
            name: "Алиса",
            score: 1234,
            avatarSystemName: "person.crop.circle.fill"
        )
    )
}
