import Foundation

// Thin wrapper around UserDefaults with JSON encoding support for any Codable type.
// Uses a dedicated suite so DataLab keys don't pollute the main app's UserDefaults.
final class UserDefaultsStorage {
    private let defaults: UserDefaults

    init(suiteName: String = "com.just3000.datalab") {
        self.defaults = UserDefaults(suiteName: suiteName) ?? .standard
    }

    func set<T: Encodable>(_ value: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        defaults.set(data, forKey: key)
    }

    func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
