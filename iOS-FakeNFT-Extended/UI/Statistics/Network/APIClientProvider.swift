//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

@MainActor
@Observable
final class APIClientProvider {
    let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    static func live(baseURL: String) -> APIClientProvider {
        APIClientProvider(client: APIClient(baseURL: baseURL))
    }
}
