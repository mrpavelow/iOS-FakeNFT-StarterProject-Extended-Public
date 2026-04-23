import Foundation

final class ProfileServiceImp: ProfileService {
    private let networkClient: NetworkClient
    private let callbackQueue: DispatchQueue
    
    init(
        networkClient: NetworkClient,
        callbackQueue: DispatchQueue = .main
    ) {
        self.networkClient = networkClient
        self.callbackQueue = callbackQueue
    }
    
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        Task {
            do {
                let request = ProfileRequest()
                let profile: Profile = try await networkClient.send(request: request)
                callbackQueue.async {
                    completion(.success(profile))
                }
            } catch {
                callbackQueue.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
