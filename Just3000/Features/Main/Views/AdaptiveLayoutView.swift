import SwiftUI
import SwiftData

struct AdaptiveLayoutView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            TabBarLayoutView()
        } else {
            SidebarLayoutView()
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    AdaptiveLayoutView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)

}
