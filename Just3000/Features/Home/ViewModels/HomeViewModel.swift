import Foundation
import SwiftData
import Observation

@Observable
final class HomeViewModel {
    var streak: Int = 0
    var longest: Int = 0
    var masteredCount: Int = 0
    var total: Int = 3000
    var goal: Int = 10
    var doneToday: Int = 0
    var dueCount: Int = 0
    var sessions: Int = 0
    var stageCounts: [String: Int] = [
        "mastered": 0,
        "mature":   0,
        "young":    0,
        "learning": 0
    ]

    var questDone: Bool { doneToday >= goal }

    private var storage: LocalDataManager?

    func load(context: ModelContext) {
        storage = LocalDataManager(modelContext: context)
        reload()
    }

    func reload() {
        guard let storage else { return }

        streak   = storage.getInt(forKey: .currentStreak)
        longest  = storage.getInt(forKey: .longestStreak)
        sessions = storage.getInt(forKey: .sessionCount)

        let savedGoal = storage.getInt(forKey: .dailyGoal)
        goal = savedGoal > 0 ? savedGoal : 10

        // doneToday resets at midnight — only count if last session was today
        if let lastDate = storage.getDate(forKey: .lastSessionDate),
           Calendar.current.isDateInToday(lastDate) {
            doneToday = storage.getInt(forKey: .doneTodayCount)
        } else {
            doneToday = 0
        }

        let allProgress = storage.fetchAll(WordProgress.self)
        let now = Date()

        var counts: [String: Int] = [
            "mastered": 0,
            "mature":   0,
            "young":    0,
            "learning": 0
        ]
        var dueNow = 0

        for item in allProgress {
            let key = item.stage.rawValue
            if counts[key] != nil {
                counts[key]! += 1
            }
            if let next = item.nextReviewDate, next <= now {
                dueNow += 1
            }
        }

        stageCounts   = counts
        masteredCount = counts["mastered"] ?? 0
        dueCount      = dueNow
    }
}
