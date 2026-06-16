import Foundation
import Observation

@Observable
final class HomeViewModel {
    var streak: Int = 7
    var longest: Int = 14
    var masteredCount: Int = 312
    var total: Int = 3000
    var goal: Int = 20
    var doneToday: Int = 8
    var dueCount: Int = 24
    var sessions: Int = 42
    var stageCounts: [String: Int] = [
        "mastered": 312,
        "mature": 156,
        "young": 89,
        "learning": 47
    ]

    var questDone: Bool { doneToday >= goal }
}
