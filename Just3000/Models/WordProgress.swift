import Foundation
import SwiftData

enum WordStage: String, Codable, CaseIterable {
    case new = "new"
    case learning = "learning"
    case young = "young"
    case mature = "mature"
    case mastered = "mastered"

    var label: String {
        switch self {
        case .new:      return "New"
        case .learning: return "Learning"
        case .young:    return "Young"
        case .mature:   return "Mature"
        case .mastered: return "Mastered"
        }
    }

    var colorHex: String {
        switch self {
        case .new:      return "#8E8E93"
        case .learning: return "#FF9500"
        case .young:    return "#007AFF"
        case .mature:   return "#AF52DE"
        case .mastered: return "#34C759"
        }
    }
}

@Model
final class WordProgress {
    var wordRank: Int = 0
    var stageRaw: String = WordStage.new.rawValue
    var lastReviewDate: Date?
    var nextReviewDate: Date?
    var easeFactor: Double = 2.5
    var timesSeen: Int = 0
    var correctCount: Int = 0

    init(wordRank: Int) {
        self.wordRank = wordRank
        self.stageRaw = WordStage.new.rawValue
        self.easeFactor = 2.5
        self.timesSeen = 0
        self.correctCount = 0
    }

    var stage: WordStage {
        get { WordStage(rawValue: stageRaw) ?? .new }
        set { stageRaw = newValue.rawValue }
    }
}

// MARK: - SRS helpers

extension WordStage {
    var advancedStage: WordStage {
        switch self {
        case .new:      return .learning
        case .learning: return .young
        case .young:    return .mature
        case .mature:   return .mastered
        case .mastered: return .mastered
        }
    }

    var regressedStage: WordStage {
        switch self {
        case .new:      return .learning
        case .learning: return .learning
        case .young:    return .learning
        case .mature:   return .young
        case .mastered: return .mature
        }
    }

    // Seconds until next review after reaching this stage
    var reviewInterval: TimeInterval {
        switch self {
        case .new:      return 86_400
        case .learning: return 86_400          // 1 day
        case .young:    return 3 * 86_400      // 3 days
        case .mature:   return 7 * 86_400      // 7 days
        case .mastered: return 21 * 86_400     // 21 days
        }
    }
}
