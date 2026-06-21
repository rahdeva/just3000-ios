import Foundation

final class UserDefaultsPreferencesRepository: AppPreferencesRepository {
    private let storage: UserDefaultsStorage
    private let themeModeKey = "datalab.themeMode"

    init(storage: UserDefaultsStorage) {
        self.storage = storage
    }

    func getThemeMode() -> AppThemeMode {
        storage.get(AppThemeMode.self, forKey: themeModeKey) ?? .system
    }

    func setThemeMode(_ mode: AppThemeMode) {
        storage.set(mode, forKey: themeModeKey)
    }

    func resetThemeMode() {
        storage.remove(forKey: themeModeKey)
    }
}
