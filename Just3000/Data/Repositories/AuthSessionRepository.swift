import Foundation

// Any storage technology that wants to manage auth sessions must implement this.
// Currently: Keychain. Later could be encrypted file, secure enclave, etc.
protocol AuthSessionRepository {
    func save(_ session: UserSession) throws
    func read() throws -> UserSession?
    func delete() throws
}
