import Foundation

protocol ProfileService {
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}
