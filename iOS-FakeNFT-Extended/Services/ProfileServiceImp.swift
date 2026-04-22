import Foundation

actor ProfileServiceImp: ProfileService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadProfile() async throws -> Profile {
                let request = ProfileRequest()
                return try await networkClient.send(request: request)
    }
    
    func saveProfile(profile: Profile) async throws -> Profile {
            let request = ProfileRequest()
            return try await networkClient.send(request: request)
    }
}
