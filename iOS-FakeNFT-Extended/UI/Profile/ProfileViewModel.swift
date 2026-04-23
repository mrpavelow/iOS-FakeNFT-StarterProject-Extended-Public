import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let profileService: ProfileService
    
    @Published private(set) var state: State = .idle
    @Published private(set) var profile: Profile? = nil
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    func loadProfile() {
        guard case .loading = state else {
            state = .loading
            
            profileService.loadProfile { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let profile):
                    self.profile = profile
                    self.state = .loaded
                case .failure:
                    self.state = .failed("Не удалось загрузить профиль")
                }
            }
            
            return
        }
    }
}
