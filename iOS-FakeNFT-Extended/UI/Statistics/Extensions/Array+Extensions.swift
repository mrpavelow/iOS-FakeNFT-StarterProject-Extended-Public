//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

extension Array where Element == NFTItem {
    func sorted(by sortingOrder: NFTSortOrder) -> [NFTItem] {
        switch sortingOrder {
        case .byPrice: sorted { $0.price < $1.price }
        case .byRating: sorted { $0.rating > $1.rating }
        case .byName: sorted { $0.name < $1.name }
        case .byInput: self
        }
    }
}
