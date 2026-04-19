//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import Foundation

enum ProfileState: Sendable {
    case idle
    case loaded(Profile)
    
    var isLoading: Bool {
        switch self {
        case .idle: true
        case .loaded: false
        }
    }
}
