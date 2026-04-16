//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 08.04.2026.
//
import Foundation

struct StatisticsUser: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let score: Int
    let avatarSystemName: String?
}
