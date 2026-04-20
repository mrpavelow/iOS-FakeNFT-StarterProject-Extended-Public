//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

/// Протокол клиента для работы с API
protocol APIClientProtocol {
    /// Загружает NFT по id
    func fetchNFT(id: String) async throws -> NFTItem
    
    /// Загружает список пользователей с возможностью сортировки и пагинации
    func fetchUsers(sortBy: String?, page: Int?, size: Int?) async throws -> [UserDTO]
    
    /// Загружает пользователя по id
    func fetchUser(id: String) async throws -> UserDTO
}

actor APIClient: APIClientProtocol {
    private let baseURL: String
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = JSONDecoder()
    }
    
    private func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint.path) else {
            throw APIClientError.invalidURL(endPoint: endpoint)
        }
        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }
        guard let url = components.url else {
            throw APIClientError.invalidURL(endPoint: endpoint)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        if let body = endpoint.body {
            request.httpBody = body
            request.setValue(endpoint.contentType, forHTTPHeaderField: "Content-Type")
        }
        request.addValue(RequestConstants.apiToken, forHTTPHeaderField: RequestConstants.token)
        request.httpBody = endpoint.body
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            debugPrint("❌ Failed to perform request, error: \(error), ➡️ endpoint: \(endpoint)")
            throw APIClientError.transport(error, endPoint: endpoint)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            debugPrint("❌ Invalid response from server, ➡️ endpoint: \(endpoint)")
            throw APIClientError.server(statusCode: -1, endPoint: endpoint, message: nil)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            debugPrint("❌ Invalid response from server: \(httpResponse.statusCode), \(message ?? "no message"), ➡️ endpoint: \(endpoint)")
            throw APIClientError.server(statusCode: httpResponse.statusCode, endPoint: endpoint, message: message)
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint("❌ Failed to decode: \(error), ➡️ endpoint: \(endpoint)")
            throw APIClientError.decoding(error, endPoint: endpoint)
        }
    }
    
    func fetchNFT(id: String) async throws -> NFTItem {
        try await request(.nft(id: id))
    }
    
    func fetchUsers(sortBy: String?, page: Int?, size: Int?) async throws -> [UserDTO] {
        try await request(.users(sortBy: sortBy, page: page, size: size))
    }
    
    func fetchUser(id: String) async throws -> UserDTO {
        try await request(.user(id: id))
    }
}
