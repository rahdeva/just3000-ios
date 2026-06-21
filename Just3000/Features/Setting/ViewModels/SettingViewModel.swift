import Foundation
import SwiftData
import Observation

@Observable
final class SettingViewModel {
    var dailyGoal: Int = 10 {
        didSet { storage?.set(dailyGoal, forKey: .dailyGoal) }
    }
    var reminderEnabled: Bool = false {
        didSet { storage?.set(reminderEnabled, forKey: .reminderEnabled) }
    }
    var icloudEnabled: Bool = false {
        didSet { storage?.set(icloudEnabled, forKey: .icloudEnabled) }
    }
    var showResetAlert: Bool = false

    private var storage: LocalDataManager?

    func load(context: ModelContext) {
        storage = LocalDataManager(modelContext: context)
        reload()
    }

    func reload() {
        guard let storage else { return }
        let savedGoal = storage.getInt(forKey: .dailyGoal)
        dailyGoal = savedGoal > 0 ? savedGoal : 10
        reminderEnabled = storage.getBool(forKey: .reminderEnabled)
        icloudEnabled = storage.getBool(forKey: .icloudEnabled)
    }

    func resetProgress() {
        guard let storage else { return }
        storage.set(0, forKey: .currentStreak)
        storage.set(0, forKey: .longestStreak)
        storage.set(0, forKey: .sessionCount)
        storage.set(0, forKey: .totalXP)
        storage.set(0, forKey: .doneTodayCount)
        storage.remove(forKey: .lastSessionDate)
        storage.setDictionary([:], forKey: .dailyActivity)
        storage.deleteAll(WordProgress.self)
    }
}
