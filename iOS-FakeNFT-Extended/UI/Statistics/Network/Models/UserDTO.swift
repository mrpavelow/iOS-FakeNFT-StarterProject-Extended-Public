//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

/// DTO пользователя, приходящий с сервера
struct UserDTO: Decodable, Hashable {
    
    /// Имя пользователя
    let name: String?
    
    /// Ссылка на аватар пользователя (строка с URL)
    let avatar: String?
    
    /// Описание профиля
    let description: String?
    
    /// Сайт пользователя
    let website: String?
    
    /// Список NFT (id или ссылки)
    let nfts: [String]?
    
    /// Уникальный идентификатор пользователя
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
