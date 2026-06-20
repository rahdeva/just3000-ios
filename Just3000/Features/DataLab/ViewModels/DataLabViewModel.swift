import Foundation
import Observation

@Observable
final class DataLabViewModel {

    // MARK: - Selected storage (read-only display, set at init)
    let storageType: DataLabStorageType

    // MARK: - Preferences Lab (UserDefaults)
    var currentThemeMode: AppThemeMode = .system
    var selectedThemeMode: AppThemeMode = .system

    // MARK: - Word CRUD Lab (File Storage)
    var words: [WordItem] = []
    var newWordText: String = ""
    var newWordMeaning: String = ""
    var editingWord: WordItem?
    var editWordText: String = ""
    var editWordMeaning: String = ""

    // MARK: - Session Lab (Keychain)
    var accessToken: String = ""
    var refreshToken: String = ""
    var currentSession: UserSession?

    // MARK: - Shared
    var results: [DataLabResult] = []

    var scenario: DataLabScenario { storageType.scenario }

    // MARK: - Repositories
    private let preferencesRepo: any AppPreferencesRepository
    private let wordRepo: (any WordRepository)?
    private let sessionRepo: any AuthSessionRepository

    init(storageType: DataLabStorageType) {
        self.storageType = storageType
        self.preferencesRepo = DataLabRepositoryFactory.makePreferencesRepository()
        self.wordRepo = DataLabRepositoryFactory.makeWordRepository(for: storageType)
        self.sessionRepo = DataLabRepositoryFactory.makeSessionRepository()
    }

    // MARK: - Load on appear

    func refreshData() {
        switch scenario {
        case .preferences: loadThemeMode()
        case .wordCRUD:    loadWords()
        case .session:     loadSession()
        }
    }

    // MARK: - Preferences Lab

    func loadThemeMode() {
        currentThemeMode = preferencesRepo.getThemeMode()
        selectedThemeMode = currentThemeMode
        log(operation: "Read Theme Mode", success: true, detail: "Current: \(currentThemeMode.label)")
    }

    func saveThemeMode() {
        preferencesRepo.setThemeMode(selectedThemeMode)
        currentThemeMode = selectedThemeMode
        log(operation: "Save Theme Mode", success: true, detail: "Saved: \(selectedThemeMode.label)")
    }

    func resetThemeMode() {
        preferencesRepo.resetThemeMode()
        currentThemeMode = .system
        selectedThemeMode = .system
        log(operation: "Reset Theme Mode", success: true, detail: "Reset to .system (default)")
    }

    // MARK: - Word CRUD Lab

    func loadWords() {
        guard let repo = wordRepo else { return }
        do {
            words = try repo.readAll()
            log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
        } catch {
            log(operation: "Read All Words", success: false, detail: error.localizedDescription)
        }
    }

    func createWord() {
        guard !newWordText.isEmpty, !newWordMeaning.isEmpty, let repo = wordRepo else { return }
        let item = WordItem(
            word: newWordText.trimmingCharacters(in: .whitespaces),
            meaning: newWordMeaning.trimmingCharacters(in: .whitespaces)
        )
        do {
            try repo.create(item)
            newWordText = ""
            newWordMeaning = ""
            loadWords()
            log(operation: "Create Word", success: true, detail: "Created: \"\(item.word)\"")
        } catch {
            log(operation: "Create Word", success: false, detail: error.localizedDescription)
        }
    }

    func startEditing(_ word: WordItem) {
        editingWord = word
        editWordText = word.word
        editWordMeaning = word.meaning
    }

    func cancelEditing() {
        editingWord = nil
        editWordText = ""
        editWordMeaning = ""
    }

    func updateWord() {
        guard var word = editingWord, !editWordText.isEmpty, !editWordMeaning.isEmpty,
              let repo = wordRepo else { return }
        word.word = editWordText.trimmingCharacters(in: .whitespaces)
        word.meaning = editWordMeaning.trimmingCharacters(in: .whitespaces)
        do {
            try repo.update(word)
            cancelEditing()
            loadWords()
            log(operation: "Update Word", success: true, detail: "Updated: \"\(word.word)\"")
        } catch {
            log(operation: "Update Word", success: false, detail: error.localizedDescription)
        }
    }

    func deleteWord(_ word: WordItem) {
        guard let repo = wordRepo else { return }
        do {
            try repo.delete(id: word.id)
            loadWords()
            log(operation: "Delete Word", success: true, detail: "Deleted: \"\(word.word)\"")
        } catch {
            log(operation: "Delete Word", success: false, detail: error.localizedDescription)
        }
    }

    // MARK: - Session Lab

    func loadSession() {
        do {
            currentSession = try sessionRepo.read()
            if let session = currentSession {
                log(operation: "Read Session", success: true, detail: "Token found: ...\(session.accessToken.suffix(8))")
            } else {
                log(operation: "Read Session", success: true, detail: "No session stored yet.")
            }
        } catch {
            log(operation: "Read Session", success: false, detail: error.localizedDescription)
        }
    }

    func saveSession() {
        guard !accessToken.isEmpty else { return }
        let session = UserSession(
            accessToken: accessToken.trimmingCharacters(in: .whitespaces),
            refreshToken: refreshToken.trimmingCharacters(in: .whitespaces),
            expiresAt: Date().addingTimeInterval(3600)
        )
        do {
            try sessionRepo.save(session)
            currentSession = session
            accessToken = ""
            refreshToken = ""
            log(operation: "Save Session", success: true, detail: "Token saved to Keychain.")
        } catch {
            log(operation: "Save Session", success: false, detail: error.localizedDescription)
        }
    }

    func deleteSession() {
        do {
            try sessionRepo.delete()
            currentSession = nil
            log(operation: "Delete Session", success: true, detail: "Session cleared from Keychain.")
        } catch {
            log(operation: "Delete Session", success: false, detail: error.localizedDescription)
        }
    }

    // MARK: - Operation Log

    private func log(operation: String, success: Bool, detail: String) {
        results.insert(DataLabResult(operation: operation, success: success, detail: detail), at: 0)
    }
}
