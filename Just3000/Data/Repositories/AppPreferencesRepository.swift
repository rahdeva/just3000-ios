import Foundation

// Any storage technology that wants to manage app preferences must implement this.
// Currently: UserDefaults. Later could be CloudKit sync, iCloud Key-Value Store, etc.
protocol AppPreferencesRepository {
    func getThemeMode() -> AppThemeMode
    func setThemeMode(_ mode: AppThemeMode)
    func resetThemeMode()
}
