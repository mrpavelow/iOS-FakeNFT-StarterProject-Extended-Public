//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 16.04.2026.
//
import Foundation

enum StatisticsViewState: Equatable {
    case loading
    case content
    case empty
    case error(String)
}
