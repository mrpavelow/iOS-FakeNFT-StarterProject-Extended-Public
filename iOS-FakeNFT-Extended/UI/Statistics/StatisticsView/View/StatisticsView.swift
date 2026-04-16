//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 09.04.2026.
//
import SwiftUI

struct StatisticsView: View {
    
    @State private var viewModel = StatisticsViewModel()
    @State private var isSortSheetPresented = false
    @State private var selectedUser: StatisticsUser?    
    
    var body: some View {
        NavigationStack {
            listView
                .navigationDestination(item: $selectedUser) { user in
                    UserCardView(user: user)
                }
        }
    }
    
    private var listView: some View {
        List {
            usersList
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.white)
        .toolbar {
            toolbarView
        }
        .confirmationDialog(
            "Statistics.sort.title",
            isPresented: $isSortSheetPresented,
            titleVisibility: .visible
        ) {
            sortActions
        }
    }
    
    private var usersList: some View {
        ForEach(Array(viewModel.users.enumerated()), id: \.element.id) { offset, user in
            StatisticsCellView(index: offset + 1, user: user)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedUser = user
                }
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20)
                )
                .listRowBackground(Color.clear)
        }
    }
    
    private var toolbarView: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isSortSheetPresented = true
            } label: {
                Image(systemName: "line.3.horizontal")
            }
            .tint(.primary)
            .buttonStyle(.plain)
            .background(Color.clear)
        }
    }
    
    private var sortActions: some View {
        Group {
            Button(StatisticsSortOption.byName.title) {
                viewModel.setSort(.byName)
            }
            Button(StatisticsSortOption.byScore.title) {
                viewModel.setSort(.byScore)
            }
            Button("Закрыть", role: .cancel) { }
        }
    }
}

#Preview {
    NavigationView {
        StatisticsView()
    }
}
