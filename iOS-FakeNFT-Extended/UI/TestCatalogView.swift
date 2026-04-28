import SwiftUI

struct TestCatalogView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @State private var presentingNft = false

    var body: some View {
        Button {
            showNft()
        } label: {
            Text(Constants.openNftTitle)
                .tint(.blue)
        }
        .backgroundStyle(.background)
        .sheet(isPresented: $presentingNft) {
            NftDetailBridgeView(nftId: Constants.testNftId)
        }
    }

    func showNft() {
        presentingNft = true
    }
}

private enum Constants {
    static let openNftTitle = NSLocalizedString("Catalog.openNft", comment: "")
    static let testNftId = "7773e33c-ec15-4230-a102-92426a3a6d5a"
}

#Preview {
    TestCatalogView()
        .environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
}
