import SwiftUI

enum TabTag {
    static let test = 0
    static let statistics = 1
}

struct TabBarView: View {
    @Environment(ServicesAssembly.self) private var services: ServicesAssembly?
    
    var body: some View {
        TabView {
            ProfileView(viewModel: ProfileViewModel(profileService: services!.profileService))
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.profile", comment: ""),
                        systemImage: "person.crop.circle.fill"
                    )
                }
                .backgroundStyle(.background)
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
