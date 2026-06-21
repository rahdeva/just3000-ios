import Foundation

// Any storage technology that wants to CRUD words must implement this.
// Currently: File Storage. Later: SwiftData, Core Data, SQLite, Realm, Firebase, Supabase...
protocol WordRepository {
    func create(_ word: WordItem) throws
    func readAll() throws -> [WordItem]
    func update(_ word: WordItem) throws
    func delete(id: UUID) throws
}
