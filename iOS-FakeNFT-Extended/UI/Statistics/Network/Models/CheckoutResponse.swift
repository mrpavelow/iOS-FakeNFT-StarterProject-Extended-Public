//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

struct CheckoutResponse: Codable {
    let success: Bool
    let orderId: String
    let id: String
}

#if DEBUG
extension CheckoutResponse {
    static let mock: CheckoutResponse = .init(success: true, orderId: "123", id: "123")
}
#endif

