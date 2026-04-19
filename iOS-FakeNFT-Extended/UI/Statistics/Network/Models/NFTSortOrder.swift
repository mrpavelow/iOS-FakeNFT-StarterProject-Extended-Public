//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

enum NFTSortOrder: String, CaseIterable, Codable {
    case byPrice = "По цене"
    case byRating = "По рейтингу"
    case byName = "По названию"
    case byInput = "Не сортировать"
    
    static let myNFTStorageKey: String = "myNFTSortingOrder"
    static let myOrderStorageKey: String = "myOrderSortingOrder"
}
