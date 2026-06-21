import Foundation
import Observation
import SwiftUI
import SwiftData

// MARK: - WordStage SwiftUI colors
extension WordStage {
    var color: Color {
        switch self {
        case .new:      return Color(red: 142/255, green: 142/255, blue: 147/255)
        case .learning: return Color(red: 255/255, green: 149/255, blue: 0)
        case .young:    return Color(red: 0,       green: 122/255, blue: 1)
        case .mature:   return Color(red: 175/255, green: 82/255,  blue: 222/255)
        case .mastered: return Color(red: 52/255,  green: 199/255, blue: 89/255)
        }
    }

    var backgroundColor: Color {
        color.opacity(self == .new ? 0.14 : 0.12)
    }
}

// MARK: - LibraryWord
struct LibraryWord: Identifiable {
    var id: Int { rank }
    let rank: Int
    let word: String
    let pos: String?
    let ipa: String?
    let definition: String?
    let altDefinition: String?
    let translation: String?
    let translationDef: String?
    let example1: String?
    let example2: String?
    let translationExample: String?
    let progress: WordProgress?

    var stage: WordStage { progress?.stage ?? .new }
}

// MARK: - LibraryFilter
enum LibraryFilter: String, CaseIterable {
    case all        = "All"
    case inProgress = "In Progress"
    case mastered   = "Mastered"
}

// MARK: - LibrarySort
enum LibrarySort {
    case byRank, alphabetical
}

// MARK: - LibraryViewModel
@Observable
final class LibraryViewModel {
    var words: [LibraryWord] = []

    var masteredCount: Int {
        words.filter { $0.stage == .mastered }.count
    }

    private var cachedEntries: [WordEntry]?
    private var storage: LocalDataManager?

    func load(context: ModelContext) {
        storage = LocalDataManager(modelContext: context)
        if cachedEntries == nil {
            guard
                let url  = Bundle.main.url(forResource: "word", withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let entries = try? JSONDecoder().decode([WordEntry].self, from: data)
            else { return }
            cachedEntries = entries
        }
        reload()
    }

    func reload() {
        guard let entries = cachedEntries, let storage else { return }

        let allProgress = storage.fetchAll(WordProgress.self)
        let progressByRank = Dictionary(uniqueKeysWithValues: allProgress.map { ($0.wordRank, $0) })

        words = entries.map { entry in
            return LibraryWord(
                rank:               entry.rank,
                word:               entry.word,
                pos:                entry.pos,
                ipa:                entry.ipa,
                definition:         entry.def,
                altDefinition:      entry.alt,
                translation:        entry.id_translation,
                translationDef:     entry.idDef,
                example1:           entry.ex1,
                example2:           entry.ex2,
                translationExample: entry.idEx1,
                progress:           progressByRank[entry.rank]
            )
        }
    }

    func filtered(search: String, filter: LibraryFilter, sort: LibrarySort) -> [LibraryWord] {
        let q = search.trimmingCharacters(in: .whitespaces).lowercased()
        if !q.isEmpty {
            return words
                .filter { $0.word.lowercased().contains(q) }
                .sorted {
                    let ap = $0.word.lowercased().hasPrefix(q)
                    let bp = $1.word.lowercased().hasPrefix(q)
                    if ap != bp { return ap }
                    return $0.rank < $1.rank
                }
        }
        var result = words.filter {
            switch filter {
            case .all:        return true
            case .inProgress: return $0.stage != .new && $0.stage != .mastered
            case .mastered:   return $0.stage == .mastered
            }
        }
        switch sort {
        case .byRank:       result.sort { $0.rank < $1.rank }
        case .alphabetical: result.sort { $0.word < $1.word }
        }
        return result
    }
}
