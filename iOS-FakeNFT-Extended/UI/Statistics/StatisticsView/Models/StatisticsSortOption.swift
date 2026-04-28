//
//  StatisticsSortOption.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 09.04.2026.
//
import Foundation

enum StatisticsSortOption: String, CaseIterable, Identifiable {
    case byName
    case byScore
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .byName:  return "По имени"
        case .byScore: return "По рейтингу"
        }
    }
}
