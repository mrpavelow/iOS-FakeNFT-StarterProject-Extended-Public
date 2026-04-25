import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let profileService: ProfileService
    
    @Published private(set) var state: State = .idle
    @Published private(set) var profile: Profile?
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    func loadProfile() {
        guard case .loading = state else {
            state = .loading
            Task {
                do {
                    profile = try await profileService.loadProfile()
                    state = .loaded
                } catch {
                    state = .failed("Не удалось загрузить профиль")
                }
            }
            
            return
        }
    }
}
