import Foundation
import Security

enum KeychainError: Error, LocalizedError {
    case saveFailed(OSStatus)
    case notFound
    case deleteFailed(OSStatus)

    var errorDescription: String? {
        switch self {
        case .saveFailed(let status):  return "Keychain save failed (OSStatus \(status))."
        case .notFound:                return "Item not found in Keychain."
        case .deleteFailed(let status): return "Keychain delete failed (OSStatus \(status))."
        }
    }
}

// Thin wrapper around the Security framework Keychain C API.
// Stores arbitrary Data blobs under a (service, account) pair.
final class KeychainStorage {
    private let service: String

    init(service: String = "com.just3000.datalab") {
        self.service = service
    }

    func save(data: Data, forKey key: String) throws {
        // Delete any existing item first to allow overwrite
        let deleteQuery = baseQuery(forKey: key)
        SecItemDelete(deleteQuery as CFDictionary)

        var addQuery = baseQuery(forKey: key)
        addQuery[kSecValueData as String] = data

        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.saveFailed(status)
        }
    }

    func load(forKey key: String) throws -> Data {
        var query = baseQuery(forKey: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else {
            throw KeychainError.notFound
        }
        return data
    }

    func delete(forKey key: String) throws {
        let query = baseQuery(forKey: key)
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.deleteFailed(status)
        }
    }

    private func baseQuery(forKey key: String) -> [String: Any] {
        [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
    }
}
