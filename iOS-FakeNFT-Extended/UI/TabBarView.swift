import SwiftUI

struct TabBarView: View {
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    var body: some View {
        TabView {
            CatalogView(
                viewModel: CatalogViewModel(
                    catalogService: servicesAssembly.catalogService
                ),
                nftService: servicesAssembly.nftService
            )
            .tabItem {
                Label(
                    NSLocalizedString("Tab.catalog", comment: ""),
                    systemImage: "square.stack.3d.up.fill"
                )
            }
        }
    }
}
