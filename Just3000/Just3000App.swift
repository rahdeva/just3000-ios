import SwiftUI
import SwiftData

@main
struct Just3000App: App {
    let sharedModelContainer: ModelContainer
    @State private var generalVM: GeneralViewModel

    init() {
        let schema = Schema([WordProgress.self])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            self.sharedModelContainer = container
            self._generalVM = State(
                initialValue: GeneralViewModel(
                    modelContext: container.mainContext
                )
            )
            WordSeedService.seedIfNeeded(context: container.mainContext)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(generalVM)
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
