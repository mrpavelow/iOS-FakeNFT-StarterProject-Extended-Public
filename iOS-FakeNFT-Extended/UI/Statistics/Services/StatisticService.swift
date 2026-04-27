//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 18.04.2026.
//
import Foundation

protocol StatisticsServiceProtocol {
    func loadUsers(sortBy: StatisticsSortOption, page: Int?, size: Int?) async throws -> [UserDTO]
    func loadNFTs(ids: [String]) async throws -> [NFTItem]
}

final class StatisticsService: StatisticsServiceProtocol {
    private let api: APIClientProtocol
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func loadUsers(sortBy: StatisticsSortOption, page: Int?, size: Int?) async throws -> [UserDTO] {
        let sortByValue: String? = sortBy == .byName ? "name" : nil
        return try await api.fetchUsers(sortBy: sortByValue, page: page, size: size)
    }
    
    func loadNFTs(ids: [String]) async throws -> [NFTItem] {
        try await withThrowingTaskGroup(of: NFTItem.self) { group in
            for id in ids {
                group.addTask {
                    try await self.api.fetchNFT(id: id)
                }
            }
            var result: [NFTItem] = []
            for try await nft in group {
                result.append(nft)
            }
            return result
        }
    }
}
