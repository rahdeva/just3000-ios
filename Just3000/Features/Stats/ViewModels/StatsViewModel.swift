import Foundation
import Observation

enum StatsTab: String, CaseIterable {
    case overview = "Overview"
    case weekly   = "Weekly"
    case calendar = "Calendar"
}

@Observable
final class StatsViewModel {
    var masteredCount: Int = 312
    var total: Int = 3000
    var streak: Int = 7
    var longest: Int = 14
    var sessions: Int = 42
    var xp: Int = 3740
    var stageCounts: [String: Int] = [
        "new":      2396,
        "learning":   47,
        "young":      89,
        "mature":    156,
        "mastered":  312,
    ]

    let weekDays  = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let thisWeek  = [12, 18, 8, 22, 15, 6, 0]
    let lastWeek  = [10, 14, 15,  8, 20, 12, 5]

    let heatmap: [Int] = [
        0,1,0,2,0,1,0,
        1,2,3,1,0,2,1,
        0,0,1,2,3,1,0,
        2,3,2,1,3,2,1,
        1,0,3,4,2,0,1,
        3,2,1,2,3,4,2,
        2,1,2,3,2,1,3,
        4,3,2,4,3,2,1,
        2,3,4,3,2,3,4,
        3,2,3,4,3,2,3,
        4,3,2,3,4,3,2,
        2,3,4,3,2,1,0,
    ]

    var masteryPct: Double    { (Double(masteredCount) / Double(max(1, total))) * 100 }
    var thisWeekTotal: Int    { thisWeek.reduce(0, +) }
    var lastWeekTotal: Int    { lastWeek.reduce(0, +) }
    var weekDelta: Int        { thisWeekTotal - lastWeekTotal }
    var dailyAverage: Int     { Int(Double(thisWeekTotal) / 7.0) }
    var bestDay: Int          { thisWeek.max() ?? 0 }
    var activeDays: Int       { heatmap.filter { $0 > 0 }.count }
}
