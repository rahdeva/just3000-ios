import Foundation
import Observation
import SwiftData

struct PracticeCard: Identifiable {
    let id = UUID()
    let rank: Int
    let word: String
    let ipa: String
    let pos: String
    let definition: String
    let translation: String
    let example: String
    let stage: WordStage
}

@Observable
final class PracticeViewModel {
    var cards: [PracticeCard] = []
    var currentIndex: Int = 0
    var correct: Int = 0
    var incorrect: Int = 0

    private var cardResults: [(rank: Int, correct: Bool)] = []
    private var progressByRank: [Int: WordProgress] = [:]
    private var storage: LocalDataManager?

    var current: PracticeCard? {
        cards.indices.contains(currentIndex) ? cards[currentIndex] : nil
    }

    var progressFraction: Double {
        Double(currentIndex) / Double(max(1, cards.count))
    }

    var accuracy: Int {
        let total = correct + incorrect
        return total > 0 ? correct * 100 / total : 0
    }

    var xpEarned: Int { correct * 10 }

    func load(context: ModelContext) {
        storage = LocalDataManager(modelContext: context)
        loadCards()
    }

    func grade(correct: Bool) {
        guard let card = current else { return }
        if correct { self.correct += 1 } else { self.incorrect += 1 }
        cardResults.append((rank: card.rank, correct: correct))
    }

    @discardableResult
    func saveSession() -> PracticeResultData {
        guard let storage else {
            return PracticeResultData(correct: correct, incorrect: incorrect,
                                     total: cards.count, mastered: 0, newSeen: 0, streak: 0)
        }

        let now = Date()
        var newlyMastered = 0
        var newSeen = 0

        for result in cardResults {
            guard let progress = progressByRank[result.rank] else { continue }
            let wasNew = progress.stage == .new
            if wasNew { newSeen += 1 }
            progress.lastReviewDate = now
            progress.timesSeen += 1
            if result.correct {
                progress.correctCount += 1
                let next = progress.stage.advancedStage
                if next == .mastered && progress.stage != .mastered { newlyMastered += 1 }
                progress.stage = next
                progress.nextReviewDate = now.addingTimeInterval(next.reviewInterval)
            } else {
                let regressed = progress.stage.regressedStage
                progress.stage = regressed
                progress.nextReviewDate = now.addingTimeInterval(regressed.reviewInterval)
            }
        }
        storage.save()

        // Streak
        let lastDate = storage.getDate(forKey: .lastSessionDate)
        var currentStreak = storage.getInt(forKey: .currentStreak)
        if let last = lastDate {
            if Calendar.current.isDateInToday(last) {
                // already counted today, streak unchanged
            } else if Calendar.current.isDateInYesterday(last) {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
        } else {
            currentStreak = 1
        }
        let longest = max(storage.getInt(forKey: .longestStreak), currentStreak)
        storage.set(currentStreak, forKey: .currentStreak)
        storage.set(longest, forKey: .longestStreak)
        storage.set(now, forKey: .lastSessionDate)

        // DoneToday resets each new day
        let resetDay = lastDate == nil || !Calendar.current.isDateInToday(lastDate!)
        let prevDone = resetDay ? 0 : storage.getInt(forKey: .doneTodayCount)
        storage.set(prevDone + correct, forKey: .doneTodayCount)

        // Session count and XP
        storage.set(storage.getInt(forKey: .sessionCount) + 1, forKey: .sessionCount)
        storage.set(storage.getInt(forKey: .totalXP) + correct * 10, forKey: .totalXP)

        // Daily activity log: accumulate correct answers per calendar day
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateKey = dateFormatter.string(from: now)
        var activity = storage.getIntDictionary(forKey: .dailyActivity)
        activity[dateKey] = (activity[dateKey] ?? 0) + correct
        storage.setDictionary(activity, forKey: .dailyActivity)

        return PracticeResultData(
            correct: correct,
            incorrect: incorrect,
            total: cards.count,
            mastered: newlyMastered,
            newSeen: newSeen,
            streak: currentStreak
        )
    }

    // MARK: - Private

    private func loadCards() {
        guard let storage,
              let url = Bundle.main.url(forResource: "word", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let entries = try? JSONDecoder().decode([WordEntry].self, from: data)
        else { return }

        let entryByRank = Dictionary(uniqueKeysWithValues: entries.map { ($0.rank, $0) })
        let goal = max(storage.getInt(forKey: .dailyGoal), 10)
        let levelRaw = storage.getString(forKey: .studyLevel) ?? StudyLevel.intermediate.rawValue
        let level = StudyLevel(rawValue: levelRaw) ?? .intermediate
        let startRank = level.startRank
        let now = Date()

        let allProgress = storage.fetchAll(WordProgress.self)
        progressByRank = Dictionary(uniqueKeysWithValues: allProgress.map { ($0.wordRank, $0) })

        let due = allProgress
            .filter { $0.stage != .new && $0.nextReviewDate != nil && $0.nextReviewDate! <= now }
            .sorted { $0.wordRank < $1.wordRank }

        let newPool = allProgress
            .filter { $0.stage == .new && $0.wordRank >= startRank }
            .sorted { $0.wordRank < $1.wordRank }
            .prefix(max(0, goal - due.count))

        let toStudy = Array((due + Array(newPool)).prefix(goal))

        cards = toStudy.compactMap { progress in
            guard let entry = entryByRank[progress.wordRank] else { return nil }
            return PracticeCard(
                rank: entry.rank,
                word: entry.word,
                ipa: entry.ipa ?? "",
                pos: entry.pos ?? "",
                definition: entry.def ?? "",
                translation: entry.id_translation ?? "",
                example: entry.ex1 ?? "",
                stage: progress.stage
            )
        }
    }
}
