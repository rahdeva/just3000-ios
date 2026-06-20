import Foundation

enum FileStorageError: Error, LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        "File not found in Documents directory."
    }
}

// Reads and writes a single JSON file in the user's Documents directory.
// Generic: any Codable type can be saved and loaded.
final class FileStorageService {
    private let fileURL: URL

    init(fileName: String) {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.fileURL = documents.appendingPathComponent(fileName)
    }

    func load<T: Decodable>(_ type: T.Type) throws -> T {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw FileStorageError.fileNotFound
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(type, from: data)
    }

    func save<T: Encodable>(_ value: T) throws {
        let data = try JSONEncoder().encode(value)
        try data.write(to: fileURL, options: .atomic)
    }

    func delete() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        try FileManager.default.removeItem(at: fileURL)
    }
}
