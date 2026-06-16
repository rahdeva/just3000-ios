import Foundation
import Observation

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
    var cards: [PracticeCard] = [
        PracticeCard(rank: 1,  word: "the",  ipa: "/ðə/",   pos: "article",     definition: "Used to refer to a specific person or thing previously mentioned or known.", translation: "yang / itu",       example: "The sun rises in the east.",          stage: .mastered),
        PracticeCard(rank: 2,  word: "be",   ipa: "/biː/",  pos: "verb",        definition: "To exist; to have a particular quality or state.",                            translation: "adalah / menjadi", example: "I want to be a doctor.",              stage: .mastered),
        PracticeCard(rank: 3,  word: "to",   ipa: "/tuː/",  pos: "preposition", definition: "Expressing motion in the direction of a particular location.",               translation: "ke / untuk",       example: "I'm going to school.",                stage: .mature),
        PracticeCard(rank: 4,  word: "of",   ipa: "/ɒv/",   pos: "preposition", definition: "Expressing the relationship between a part and a whole.",                   translation: "dari / milik",     example: "A cup of tea.",                       stage: .young),
        PracticeCard(rank: 5,  word: "and",  ipa: "/ænd/",  pos: "conjunction", definition: "Used to connect words, phrases, or clauses of the same grammatical type.",  translation: "dan",              example: "Salt and pepper go well together.",   stage: .learning),
        PracticeCard(rank: 6,  word: "a",    ipa: "/eɪ/",   pos: "article",     definition: "Used when referring to someone or something for the first time.",            translation: "sebuah / seorang", example: "I saw a dog in the park.",            stage: .mastered),
        PracticeCard(rank: 7,  word: "in",   ipa: "/ɪn/",   pos: "preposition", definition: "Expressing the situation of being enclosed or surrounded by something.",    translation: "di dalam / dalam", example: "The keys are in the drawer.",         stage: .mature),
        PracticeCard(rank: 8,  word: "that", ipa: "/ðæt/",  pos: "conjunction", definition: "Used to identify a specific thing or person mentioned.",                    translation: "bahwa / itu",      example: "She said that she was tired.",        stage: .young),
        PracticeCard(rank: 9,  word: "have", ipa: "/hæv/",  pos: "verb",        definition: "To possess, own, or hold something.",                                       translation: "memiliki / punya", example: "I have two cats at home.",            stage: .learning),
        PracticeCard(rank: 10, word: "it",   ipa: "/ɪt/",   pos: "pronoun",     definition: "Used to refer to a thing previously mentioned or easily identified.",       translation: "itu / nya",        example: "Where is it? It is raining outside.", stage: .mastered),
    ]

    var currentIndex: Int = 0
    var correct: Int = 0
    var incorrect: Int = 0
    var showResult: Bool = false

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
}
