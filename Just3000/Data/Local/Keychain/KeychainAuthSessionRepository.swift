import Foundation

final class KeychainAuthSessionRepository: AuthSessionRepository {
    private let storage: KeychainStorage
    private let sessionKey = "datalab.session"

    init(storage: KeychainStorage) {
        self.storage = storage
    }

    func save(_ session: UserSession) throws {
        let data = try JSONEncoder().encode(session)
        try storage.save(data: data, forKey: sessionKey)
    }

    func read() throws -> UserSession? {
        do {
            let data = try storage.load(forKey: sessionKey)
            return try JSONDecoder().decode(UserSession.self, from: data)
        } catch KeychainError.notFound {
            // No session stored yet — return nil instead of throwing
            return nil
        }
    }

    func delete() throws {
        try storage.delete(forKey: sessionKey)
    }
}
