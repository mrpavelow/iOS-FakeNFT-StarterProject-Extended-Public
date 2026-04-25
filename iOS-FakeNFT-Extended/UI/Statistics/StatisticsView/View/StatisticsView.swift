//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Владислав on 09.04.2026.
//
import SwiftUI

struct StatisticsView: View {
    
    @State private var viewModel: StatisticsViewModel
    @State private var isSortSheetPresented = false
    @State private var selectedUser: StatisticsUser?
    
    init() {
        let api = APIClient(baseURL: RequestConstants.baseURL)
        let service = StatisticsService(api: api)
        _viewModel = State(wrappedValue: StatisticsViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            content
                .toolbar { toolbarContent }
                .confirmationDialog(
                    "Сортировка",
                    isPresented: $isSortSheetPresented,
                    titleVisibility: .visible
                ) {
                    sortDialogButtons
                }
                .navigationDestination(item: $selectedUser) { user in
                    UserCardView(user: user)
                }
        }
    }
       
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .empty:
            emptyView
        case .error(let message):
            errorView(message: message)
        case .content:
            usersListView
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            sortButton
        }
    }
    
    private var sortButton: some View {
        Button { isSortSheetPresented = true } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
    
    private var sortDialogButtons: some View {
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

    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyView: some View {
        Text("Нет пользователей")
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
    
    private var errorTitleText: some View {
        Text("Ошибка загрузки")
    }
    
    private func errorMessageText(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .multilineTextAlignment(.center)
    }
    
    private var retryButton: some View {
        Button("Повторить") {
            viewModel.retry()
        }
    }
  
    private var usersListView: some View {
        List {
            usersListContent
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
    
    private var usersListContent: some View {
        ForEach(Array(viewModel.users.enumerated()), id: \.element.id) { offset, user in
            userRowView(index: offset + 1, user: user)
                .listRowSeparator(.hidden)
                .listRowInsets(edgeInsets)
                .listRowBackground(Color.clear)
        }
    }
    
    private func userRowView(index: Int, user: StatisticsUser) -> some View {
        StatisticsCellView(index: index, user: user)
            .contentShape(Rectangle())
            .onTapGesture { selectedUser = user }
    }
    
    private var edgeInsets: EdgeInsets {
        EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20)
    }
}
