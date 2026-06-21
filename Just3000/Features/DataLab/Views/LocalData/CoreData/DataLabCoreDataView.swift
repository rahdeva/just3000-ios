import SwiftUI

struct DataLabCoreDataView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .coreData,
            about: "Apple's mature object-graph and persistence framework, available since iOS 3. Based on NSManagedObject and NSManagedObjectContext. Supports complex relationships, undo/redo, lazy loading, faulting, and fine-grained data migration.",
            useCases: [
                "Large and complex object graphs",
                "Apps targeting iOS 16 and below",
                "Projects needing fine-grained migration control",
                "Teams migrating from existing Core Data stacks"
            ],
            note: "For new projects on iOS 17+, consider SwiftData instead. Core Data is still fully supported but SwiftData is the future direction from Apple."
        )
    }
}

#Preview {
    NavigationStack { DataLabCoreDataView() }
}
