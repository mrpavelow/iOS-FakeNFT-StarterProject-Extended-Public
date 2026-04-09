import SwiftUI

enum TabTag {
    static let test = 0
    static let statistics = 1
}

struct TabBarView: View {
    var body: some View {
        TabView {
            TestCatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: "square.stack.3d.up.fill"
                    )
                }
                .backgroundStyle(.background)
            
            StatisticsView()
                .tabItem {
                    Label("Статистика", systemImage: "flag.2.crossed.fill")
                }
                .backgroundStyle(.background)
                .tag(TabTag.statistics)
        }
    }
}
