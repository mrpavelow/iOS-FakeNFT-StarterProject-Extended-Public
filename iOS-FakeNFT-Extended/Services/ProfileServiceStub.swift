import Foundation

struct ProfileServiceStub: ProfileService {
    let result: Result<Profile, Error>
    
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        completion(result)
    }
}
