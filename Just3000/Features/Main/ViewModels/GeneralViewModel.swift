import Foundation
import SwiftData
import Observation

enum StudyLevel: String, CaseIterable {
    case beginner     = "Beginner"
    case intermediate = "Intermediate"
    case advanced     = "Advanced"

    var startRank: Int {
        switch self {
            case .beginner:     return 1
            case .intermediate: return 501
            case .advanced:     return 1001
        }
    }
}

@Observable
final class GeneralViewModel {
    var hasCompletedOnboarding: Bool {
        didSet { storage.set(hasCompletedOnboarding, forKey: .hasCompletedOnboarding) }
    }
    var selectedLanguage: AppLanguage {
        didSet { storage.set(selectedLanguage.rawValue, forKey: .selectedLanguage) }
    }
    var studyLevel: StudyLevel {
        didSet { storage.set(studyLevel.rawValue, forKey: .studyLevel) }
    }
    var dailyGoal: Int {
        didSet { storage.set(dailyGoal, forKey: .dailyGoal) }
    }

    private let storage: LocalDataManager

    init(modelContext: ModelContext) {
        self.storage = LocalDataManager(modelContext: modelContext)

        self.hasCompletedOnboarding = storage.getBool(forKey: .hasCompletedOnboarding)
        let langRaw = storage.getString(forKey: .selectedLanguage) ?? AppLanguage.english.rawValue
        self.selectedLanguage = AppLanguage(rawValue: langRaw) ?? .english
        let levelRaw = storage.getString(forKey: .studyLevel) ?? StudyLevel.intermediate.rawValue
        self.studyLevel = StudyLevel(rawValue: levelRaw) ?? .intermediate
        self.dailyGoal = storage.getInt(forKey: .dailyGoal) > 0 ? storage.getInt(forKey: .dailyGoal) : 10
    }

    func completeOnboarding(level: StudyLevel, goal: Int) {
        studyLevel = level
        dailyGoal = goal
        hasCompletedOnboarding = true
    }
}
