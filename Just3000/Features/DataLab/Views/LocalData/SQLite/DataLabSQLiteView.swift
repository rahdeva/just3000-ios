import SwiftUI

struct DataLabSQLiteView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .sqlite,
            about: "A serverless, self-contained relational database embedded directly in the app bundle. Supports full SQL queries with JOINs, indexes, and transactions. Typically accessed via a Swift wrapper like SQLite.swift or GRDB.swift for type-safe query building.",
            useCases: [
                "Large read-heavy datasets (e.g. dictionaries, catalogs)",
                "Complex SQL queries with joins and aggregations",
                "Cross-platform schema sharing (iOS + Android + server)",
                "Full control over query performance and indexing"
            ],
            note: "GRDB.swift adds type-safety, observation (reactive queries), and a clean Swift API on top of raw SQLite. It's the recommended way to use SQLite on iOS."
        )
    }
}

#Preview {
    NavigationStack { DataLabSQLiteView() }
}
