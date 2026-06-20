import Foundation

final class FileWordRepository: WordRepository {
    private let service: FileStorageService

    init(service: FileStorageService) {
        self.service = service
    }

    // Loads the JSON array from disk, or returns empty if file doesn't exist yet
    private func loadAll() -> [WordItem] {
        (try? service.load([WordItem].self)) ?? []
    }

    private func saveAll(_ words: [WordItem]) throws {
        try service.save(words)
    }

    func create(_ word: WordItem) throws {
        var words = loadAll()
        words.append(word)
        try saveAll(words)
    }

    func readAll() throws -> [WordItem] {
        loadAll()
    }

    func update(_ word: WordItem) throws {
        var words = loadAll()
        guard let index = words.firstIndex(where: { $0.id == word.id }) else { return }
        words[index] = word
        try saveAll(words)
    }

    func delete(id: UUID) throws {
        var words = loadAll()
        words.removeAll { $0.id == id }
        try saveAll(words)
    }
}
