//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

struct UserDTO: Decodable, Hashable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [String]?
    let id: String?
}

extension UserDTO {
    
    var avatarURL: URL? {
        guard let avatar else { return nil }
        let trimmed = avatar.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return URL(string: trimmed)
    }
}
