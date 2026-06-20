import Foundation

// Creates the correct repository implementation for a given storage type.
// The ViewModel and Views never import or know about the concrete implementations.
enum DataLabRepositoryFactory {

    static func makePreferencesRepository() -> any AppPreferencesRepository {
        let storage = UserDefaultsStorage()
        return UserDefaultsPreferencesRepository(storage: storage)
    }

    static func makeWordRepository(for type: DataLabStorageType) -> (any WordRepository)? {
        switch type {
        case .fileStorage:
            let service = FileStorageService(fileName: "datalab_words.json")
            return FileWordRepository(service: service)
        default:
            // Other storage types not yet implemented
            return nil
        }
    }

    static func makeSessionRepository() -> any AuthSessionRepository {
        let storage = KeychainStorage()
        return KeychainAuthSessionRepository(storage: storage)
    }
}
