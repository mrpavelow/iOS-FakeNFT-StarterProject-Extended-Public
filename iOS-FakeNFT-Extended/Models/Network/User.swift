//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 08.04.2026.
//
import Foundation

struct User: Codable {
    let id: String
    let name: String
    let avatar: String
    let description: String?
    let website: String
    let nfts: [String]
    let rating: String
    
    var nftAmount: Int {
        nfts.count
    }
}
