import Foundation

struct WordItem: Identifiable, Codable, Equatable {
    var id: UUID
    var word: String
    var meaning: String
    var createdAt: Date

    init(id: UUID = UUID(), word: String, meaning: String, createdAt: Date = Date()) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.createdAt = createdAt
    }
}
