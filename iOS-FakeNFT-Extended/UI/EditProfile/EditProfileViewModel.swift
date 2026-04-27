import Foundation
import SwiftUI

@MainActor
final class ProfileEditViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    private let profileService: ProfileService
    
    @Published private(set) var state: State = .loaded
    @Published private(set) var profile: Profile
    @Published private(set) var profileIsChanged: Bool = false
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var website: String = ""
    @Published var avatar: String = ""
    @Published var showEditAvatarMenu: Bool = false
    @Published var showEditAvatarDialog: Bool = false
    @Published var showEditAlert: Bool = false
    
    init(profileService: ProfileService, profile: Profile) {
        self.profileService = profileService
        self.profile = profile
        self.name = profile.name
        self.description = profile.description
        self.website = profile.website
        self.avatar = profile.avatar
        
        $name.combineLatest($description, $website, $avatar).map { [weak self] name, description, website, avatar in
            name != self?.profile.name || description != self?.profile.description || website != self?.profile.website || avatar != self?.profile.avatar
        }.assign(to: &$profileIsChanged)
    }
    
    func saveProfile() {
        guard case .loading = state else {
            state = .loading
            
            let editedProfile = Profile(name: name,
                                        avatar: profile.avatar,
                                        description: description,
                                        website: website,
                                        nfts: profile.nfts,
                                        likes: profile.likes,
                                        id: profile.id)
            
            Task {
                do {
                    profile = try await profileService.saveProfile(profile: editedProfile)
                    name = profile.name
                    description = profile.description
                    website = profile.website
                    avatar = profile.avatar
                    
                    state = .loaded
                } catch {
                    state = .failed("Не удалось сохранить профиль")
                }
            }
            return
        }
    }
}
