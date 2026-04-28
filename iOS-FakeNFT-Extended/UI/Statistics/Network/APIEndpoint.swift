//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

enum APIEndpoint {
    case nft(id: String)
    case users(sortBy: String?, page: Int?, size: Int?)
    case user(id: String)
    
    var path: String {
        switch self {
        case .nft(let id): "/api/v1/nft/\(id)"
        case .users: "/api/v1/users"
        case .user(let id): "/api/v1/users/\(id)"
        }
    }
    
    var contentType: String {
        "application/json"
    }
    
    var method: String {
        "GET"
    }
    
    var body: Data? {
        nil
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .users(let sortBy, let page, let size):
            var items: [URLQueryItem] = []
            if let sortBy { items.append(URLQueryItem(name: "sortBy", value: sortBy)) }
            if let page { items.append(URLQueryItem(name: "page", value: String(page))) }
            if let size { items.append(URLQueryItem(name: "size", value: String(size))) }
            return items
        default:
            return []
        }
    }
}


