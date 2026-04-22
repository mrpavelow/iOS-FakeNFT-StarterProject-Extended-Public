import Foundation

struct ProfileServiceStub: ProfileService {
    let profile: Profile
    
    func loadProfile() async throws -> Profile {
        return profile
    }
    
    func saveProfile(profile: Profile) -> Profile {
        return profile
    }
}
