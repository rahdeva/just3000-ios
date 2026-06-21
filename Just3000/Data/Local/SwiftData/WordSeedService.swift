import Foundation
import SwiftData

enum WordSeedService {
    static func seedIfNeeded(context: ModelContext) {
        let existing = (try? context.fetchCount(FetchDescriptor<WordProgress>())) ?? 0
        guard existing == 0 else { return }

        guard
            let url = Bundle.main.url(forResource: "word", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let entries = try? JSONDecoder().decode([WordEntry].self, from: data)
        else { return }

        for entry in entries {
            context.insert(WordProgress(wordRank: entry.rank))
        }
        try? context.save()
    }
}
