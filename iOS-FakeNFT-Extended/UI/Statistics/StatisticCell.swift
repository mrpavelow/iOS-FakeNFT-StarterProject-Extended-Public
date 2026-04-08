//
//  StatisticCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 08.04.2026.
//
import SwiftUI
import Kingfisher

struct StatisticCell: View {
    let user: User
    let place: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(place)")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.primary)
                .frame(width: 27, alignment: .center)
            
            HStack(spacing: 8) {
                KFImage(URL(string: user.avatar))
                    .placeholder {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(.systemGray))
                            .font(.system(size: 28))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                
                Text(user.name)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer(minLength: 8)
                
                Text("\(user.nftAmount)")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .background(Color("yLightGray"))
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .background(Color.clear)
    }
}

#Preview {
    StatisticCell(
        user: User(
            id: "1",
            name: "Алиса",
            avatar: "https://example.com/avatar.jpg",
            description: "Коллекционер",
            website: "https://alice.com",
            nfts: ["1", "2", "3"],
            rating: "95"
        ),
        place: 1
    )
}
