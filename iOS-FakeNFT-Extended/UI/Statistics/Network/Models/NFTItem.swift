//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 18.04.2026.
//

import Foundation

struct NFTItem: Decodable, Identifiable, Hashable {
    let name: String
    let images: [String]
    let rating: Int
    let price: Double
    let id: String
    var priceString: String {
        String(format: "%.2f", price)
    }
}

extension NFTItem {
    static let mock = NFTItem(
        name: "Zeus",
        images: ["https://picsum.photos/400/400?random=1"],
        rating: 5,
        price: 1.79,
        id: "mock_id"
    )
}
