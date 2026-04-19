//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation
import SwiftUI

struct UserCollectionView: View {
    
    let title: String
    let nftIds: [String]
    
    @State private var viewModel: UserCollectionViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    init(title: String, nftIds: [String], service: StatisticsServiceProtocol) {
        self.title = title
        self.nftIds = nftIds
        _viewModel = State(initialValue: UserCollectionViewModel(service: service, nftIds: nftIds))
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .error(let message):
                errorView(message: message)
            case .content(let nfts):
                contentView(nfts: nfts)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyView: some View {
        Text("Коллекция пуста")
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            errorTitleText
            errorMessageText(message)
            retryButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func contentView(nfts: [NFTItem]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                nftGridItems(nfts: nfts)
            }
            .padding()
        }
    }
    
    private var errorTitleText: some View {
        Text("Ошибка загрузки")
    }
    
    private func errorMessageText(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
    
    private var retryButton: some View {
        Button("Повторить") {
            viewModel.retry()
        }
    }
    
    private func nftGridItems(nfts: [NFTItem]) -> some View {
        ForEach(nfts, id: \.id) { nft in
            NFTCardView(nft: nft)
        }
    }
}

#Preview {
    class MockStatisticsService: StatisticsServiceProtocol {
        func loadUsers(sortBy: StatisticsSortOption, page: Int?, size: Int?) async throws -> [UserDTO] {
            return []
        }
        
        func loadNFTs(ids: [String]) async throws -> [NFTItem] {
            return [NFTItem.mock]
        }
    }
    let mockService = MockStatisticsService()
    let mockNFTIds = ["mock_id_1", "mock_id_2"]
    
    return NavigationStack {
        UserCollectionView(
            title: "Коллекция NFT",
            nftIds: mockNFTIds,
            service: mockService
        )
    }
}
