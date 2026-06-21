import Foundation
import Observation
import SwiftData

enum StatsTab: String, CaseIterable {
    case overview = "Overview"
    case weekly   = "Weekly"
    case calendar = "Calendar"
}

@Observable
final class StatsViewModel {
    var masteredCount: Int = 0
    var total: Int = 3000
    var streak: Int = 0
    var longest: Int = 0
    var sessions: Int = 0
    var xp: Int = 0
    var stageCounts: [String: Int] = [
        "new": 0, "learning": 0, "young": 0, "mature": 0, "mastered": 0
    ]

    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var thisWeek: [Int] = Array(repeating: 0, count: 7)
    var lastWeek: [Int] = Array(repeating: 0, count: 7)
    var heatmap:  [Int] = Array(repeating: 0, count: 84)

    private var storage: LocalDataManager?

    var masteryPct: Double  { (Double(masteredCount) / Double(max(1, total))) * 100 }
    var thisWeekTotal: Int  { thisWeek.reduce(0, +) }
    var lastWeekTotal: Int  { lastWeek.reduce(0, +) }
    var weekDelta: Int      { thisWeekTotal - lastWeekTotal }
    var dailyAverage: Int   { Int(Double(thisWeekTotal) / 7.0) }
    var bestDay: Int        { thisWeek.max() ?? 0 }
    var activeDays: Int     { heatmap.filter { $0 > 0 }.count }

    func load(context: ModelContext) {
        storage = LocalDataManager(modelContext: context)
        reload()
    }

    func reload() {
        guard let storage else { return }

        streak   = storage.getInt(forKey: .currentStreak)
        longest  = storage.getInt(forKey: .longestStreak)
        sessions = storage.getInt(forKey: .sessionCount)
        xp       = storage.getInt(forKey: .totalXP)

        // Stage counts from SwiftData
        let allProgress = storage.fetchAll(WordProgress.self)
        var counts: [String: Int] = ["new": 0, "learning": 0, "young": 0, "mature": 0, "mastered": 0]
        for item in allProgress {
            counts[item.stage.rawValue, default: 0] += 1
        }
        stageCounts   = counts
        masteredCount = counts["mastered"] ?? 0

        // Daily activity log
        let activity = storage.getIntDictionary(forKey: .dailyActivity)
        let cal      = Calendar.current
        let today    = cal.startOfDay(for: Date())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        // Monday of current ISO week
        let weekday       = cal.component(.weekday, from: today)   // 1=Sun, 2=Mon…
        let daysFromMonday = (weekday + 5) % 7
        let monday = cal.date(byAdding: .day, value: -daysFromMonday, to: today) ?? today

        thisWeek = (0..<7).map { i in
            let d = cal.date(byAdding: .day, value: i, to: monday) ?? today
            return activity[formatter.string(from: d)] ?? 0
        }
        lastWeek = (0..<7).map { i in
            let d = cal.date(byAdding: .day, value: i - 7, to: monday) ?? today
            return activity[formatter.string(from: d)] ?? 0
        }

        // Heatmap: 84 days ending today (col-major: 12 cols × 7 rows, Mon-Sun)
        let heatmapStart = cal.date(byAdding: .day, value: -83, to: today) ?? today
        heatmap = (0..<84).map { i in
            let d = cal.date(byAdding: .day, value: i, to: heatmapStart) ?? today
            return activity[formatter.string(from: d)] ?? 0
        }
    }
}
