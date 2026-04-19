//
//  UserCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 19.04.2026.
//
import SwiftUI

extension View {
    func hiddenWhen(_ condition: Bool) -> some View {
        opacity(condition ? 0 : 1)
    }
}
