import Foundation
import Observation
import CloudKit

@Observable
final class DataLabViewModel {

    // MARK: - Selected storage (read-only, set at init)
    let storageType: DataLabStorageType

    // MARK: - Preferences Lab (UserDefaults)
    var currentThemeMode: AppThemeMode = .system
    var selectedThemeMode: AppThemeMode = .system

    // MARK: - Word CRUD Lab (File Storage / CloudKit)
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
    var isLoading: Bool = false
    var iCloudAccountStatus: CKAccountStatus?

    var scenario: DataLabScenario { storageType.scenario }

    /// Pesan status iCloud untuk ditampilkan di view (status card).
    var iCloudStatusMessage: String? {
        guard let status = iCloudAccountStatus else { return nil }
        switch status {
        case .available:              return "Signed in — siap sync."
        case .noAccount:              return "Belum login iCloud. Buka Settings > Apple Account."
        case .restricted:             return "Akses iCloud dibatasi di perangkat ini."
        case .couldNotDetermine:      return "Tidak dapat menentukan status iCloud."
        case .temporarilyUnavailable: return "iCloud sementara tidak tersedia."
        @unknown default:             return "Status iCloud tidak diketahui."
        }
    }

    /// True hanya jika iCloud available — dipakai untuk ikon status di view.
    var isICloudAvailable: Bool { iCloudAccountStatus == .available }

    // MARK: - Repositories
    private let preferencesRepo: any AppPreferencesRepository
    private let wordRepo: (any WordRepository)?
    private let sessionRepo: any AuthSessionRepository
    /// Diisi hanya saat storageType == .cloudKit.
    private let cloudKitRepo: CloudKitWordRepository?

    init(storageType: DataLabStorageType) {
        self.storageType    = storageType
        self.preferencesRepo = DataLabRepositoryFactory.makePreferencesRepository()
        self.wordRepo        = DataLabRepositoryFactory.makeWordRepository(for: storageType)
        self.sessionRepo     = DataLabRepositoryFactory.makeSessionRepository()
        self.cloudKitRepo    = storageType == .cloudKit ? CloudKitWordRepository() : nil
    }

    // MARK: - Load on appear

    func refreshData() {
        switch scenario {
        case .preferences:
            loadThemeMode()
        case .wordCRUD:
            // Untuk CloudKit: cek status akun (info saja) lalu fetch data secara paralel
            if cloudKitRepo != nil { checkICloudStatus() }
            loadWords()
        case .session:
            loadSession()
        }
    }

    // MARK: - iCloud Status (CloudKit only)

    /// Cek status akun iCloud secara async — tidak memblok loadWords.
    /// Hasilnya ditampilkan di status card, bukan sebagai blocking gate.
    func checkICloudStatus() {
        guard let repo = cloudKitRepo else { return }
        Task { @MainActor in
            do {
                iCloudAccountStatus = try await repo.checkAccountStatus()
            } catch {
                // Silent fail — status card tidak muncul, operation log tidak terpengaruh
            }
        }
    }

    // MARK: - Preferences Lab

    func loadThemeMode() {
        currentThemeMode  = preferencesRepo.getThemeMode()
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
        currentThemeMode  = .system
        selectedThemeMode = .system
        log(operation: "Reset Theme Mode", success: true, detail: "Reset to .system (default)")
    }

    // MARK: - Word CRUD Lab

    func loadWords() {
        if let repo = cloudKitRepo {
            Task { @MainActor in
                isLoading = true
                do {
                    // Public DB: read tidak butuh login iCloud
                    words = try await repo.readAll()
                    log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
                } catch {
                    log(operation: "Read All Words", success: false, detail: error.localizedDescription)
                }
                isLoading = false
            }
        } else {
            guard let repo = wordRepo else { return }
            do {
                words = try repo.readAll()
                log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
            } catch {
                log(operation: "Read All Words", success: false, detail: error.localizedDescription)
            }
        }
    }

    func createWord() {
        guard !newWordText.isEmpty, !newWordMeaning.isEmpty else { return }
        let item = WordItem(
            word:    newWordText.trimmingCharacters(in: .whitespaces),
            meaning: newWordMeaning.trimmingCharacters(in: .whitespaces)
        )
        if let repo = cloudKitRepo {
            // Reset form segera agar UI tidak terkunci selama operasi async
            newWordText    = ""
            newWordMeaning = ""
            Task { @MainActor in
                isLoading = true
                do {
                    try await repo.create(item)
                    log(operation: "Create Word", success: true, detail: "Created: \"\(item.word)\"")
                    // Refresh list setelah create berhasil
                    words = try await repo.readAll()
                    log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
                } catch {
                    log(operation: "Create Word", success: false, detail: error.localizedDescription)
                }
                isLoading = false
            }
        } else {
            guard let repo = wordRepo else { return }
            do {
                try repo.create(item)
                newWordText    = ""
                newWordMeaning = ""
                loadWords()
                log(operation: "Create Word", success: true, detail: "Created: \"\(item.word)\"")
            } catch {
                log(operation: "Create Word", success: false, detail: error.localizedDescription)
            }
        }
    }

    func startEditing(_ word: WordItem) {
        editingWord    = word
        editWordText   = word.word
        editWordMeaning = word.meaning
    }

    func cancelEditing() {
        editingWord     = nil
        editWordText    = ""
        editWordMeaning = ""
    }

    func updateWord() {
        guard var word = editingWord, !editWordText.isEmpty, !editWordMeaning.isEmpty else { return }
        word.word    = editWordText.trimmingCharacters(in: .whitespaces)
        word.meaning = editWordMeaning.trimmingCharacters(in: .whitespaces)
        if let repo = cloudKitRepo {
            cancelEditing()
            Task { @MainActor in
                isLoading = true
                do {
                    try await repo.update(word)
                    log(operation: "Update Word", success: true, detail: "Updated: \"\(word.word)\"")
                    words = try await repo.readAll()
                    log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
                } catch {
                    log(operation: "Update Word", success: false, detail: error.localizedDescription)
                }
                isLoading = false
            }
        } else {
            guard let repo = wordRepo else { return }
            do {
                try repo.update(word)
                cancelEditing()
                loadWords()
                log(operation: "Update Word", success: true, detail: "Updated: \"\(word.word)\"")
            } catch {
                log(operation: "Update Word", success: false, detail: error.localizedDescription)
            }
        }
    }

    func deleteWord(_ word: WordItem) {
        if let repo = cloudKitRepo {
            Task { @MainActor in
                isLoading = true
                do {
                    try await repo.delete(id: word.id)
                    log(operation: "Delete Word", success: true, detail: "Deleted: \"\(word.word)\"")
                    words = try await repo.readAll()
                    log(operation: "Read All Words", success: true, detail: "Loaded \(words.count) word(s)")
                } catch {
                    log(operation: "Delete Word", success: false, detail: error.localizedDescription)
                }
                isLoading = false
            }
        } else {
            guard let repo = wordRepo else { return }
            do {
                try repo.delete(id: word.id)
                loadWords()
                log(operation: "Delete Word", success: true, detail: "Deleted: \"\(word.word)\"")
            } catch {
                log(operation: "Delete Word", success: false, detail: error.localizedDescription)
            }
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
            accessToken:  accessToken.trimmingCharacters(in: .whitespaces),
            refreshToken: refreshToken.trimmingCharacters(in: .whitespaces),
            expiresAt:    Date().addingTimeInterval(3600)
        )
        do {
            try sessionRepo.save(session)
            currentSession = session
            accessToken    = ""
            refreshToken   = ""
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
