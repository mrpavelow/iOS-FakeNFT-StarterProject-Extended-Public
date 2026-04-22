import Foundation

protocol ProfileService: Sendable {
    func loadProfile() async throws -> Profile
    
    func saveProfile(profile: Profile) async throws -> Profile
}
