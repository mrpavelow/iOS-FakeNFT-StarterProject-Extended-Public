//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 14.04.2026.
//
import SwiftUI

struct UserCollectionView: View {
    
    let title: String
    let count: Int
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            gridView
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var gridView: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<count, id: \.self) { _ in
                NFTCardView()
            }
        }
        .padding()
    }
}

struct NFTCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 92)
                .foregroundStyle(.gray.opacity(0.25))
            
            Text("NFT CARD")
                .font(.subheadline)
                .bold()
            
            Text("1.78 ETH")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        UserCollectionView(
            title: "Коллекция NFT",
            count: 112
        )
    }
}

#Preview("NFT Card Component") {
    NFTCardView()
        .padding()
        .frame(width: 150)
}
