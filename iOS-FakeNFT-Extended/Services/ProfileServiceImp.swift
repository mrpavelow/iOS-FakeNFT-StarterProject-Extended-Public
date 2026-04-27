import Foundation

actor ProfileServiceImp: ProfileService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadProfile() async throws -> Profile {
        let request = GetProfileRequest()
        return try await networkClient.send(request: request)
    }
    
    func saveProfile(profile: Profile) async throws -> Profile {
        let request = SaveProfileRequest(parameters: ["name": profile.name,
                                                      "avatar": profile.avatar,
                                                      "description": profile.description,
                                                      "website": profile.website,
                                                      "likes": profile.likes])
        return try await networkClient.send(request: request)
    }
}
