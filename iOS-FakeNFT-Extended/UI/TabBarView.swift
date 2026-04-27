import SwiftUI

enum TabTag {
    static let test = 0
    static let statistics = 1
}

struct TabBarView: View {
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    var body: some View {
        TabView {
            ProfileView(viewModel: ProfileViewModel(profileService: servicesAssembly.profileService))
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.profile", comment: ""),
                        systemImage: "person.crop.circle.fill"
                    )
                }
                .backgroundStyle(.background)
            CatalogView(
                viewModel: CatalogViewModel(
                    catalogService: servicesAssembly.catalogService
                ),
                nftService: servicesAssembly.nftService,
                profileService: servicesAssembly.profileService
            )
            .tabItem {
                Label(
                    NSLocalizedString("Tab.catalog", comment: ""),
                    systemImage: "square.stack.3d.up.fill"
                )
            }
            StatisticsView()
                .tabItem {
                    Label("Статистика", systemImage: "flag.2.crossed.fill")
                }
                .backgroundStyle(.background)
                .tag(TabTag.statistics)
        }
    }
}
