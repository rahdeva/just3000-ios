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
    AdaptiveLayoutView()
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
