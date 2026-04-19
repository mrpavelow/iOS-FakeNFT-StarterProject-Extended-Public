//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import SwiftUI
import Foundation

struct NFTCardView: View {
    
    let nft: NFTItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            nftImageView
            ratingView
            infoView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var nftImageView: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: nft.images.first ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                placeholderImage
            }
            .frame(height: 110)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            likeButton
        }
    }
    
    private var placeholderImage: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.gray.opacity(0.2))
    }
    
    private var likeButton: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(.white)
            .padding(6)
    }
    
    private var ratingView: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                starImage(for: index)
            }
        }
    }
    
    private func starImage(for index: Int) -> some View {
        Image(systemName: index < nft.rating ? "star.fill" : "star")
            .font(.caption)
            .foregroundStyle(.yellow)
    }
    
    private var infoView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                nftNameText
                nftPriceText
            }
            
            Spacer()
            
            cartButton
        }
    }
    
    private var nftNameText: some View {
        Text(nft.name)
            .font(.subheadline)
            .bold()
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 34)
    }
    
    private var nftPriceText: some View {
        Text("\(String(format: "%.2f", nft.price)) ETH")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    
    private var cartButton: some View {
        Image(systemName: "cart")
    }
}

#Preview {
    NFTCardView(nft: NFTItem.mock)
        .padding()
        .frame(width: 200)
}
