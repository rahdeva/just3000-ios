import SwiftUI
import SwiftData

struct AdaptiveLayoutView: View {
    @Binding var path: NavigationPath
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            TabBarLayoutView(path: $path)
        } else {
            SidebarLayoutView(path: $path)
        }
    }
}

#Preview {
    AdaptiveLayoutView(path: .constant(NavigationPath()))
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
