import SwiftUI
import SwiftData

struct SidebarLayoutView: View {
    @State private var selectedRoute: AppRoute? = .home

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedRoute) {
                Label("Home",     systemImage: "house.fill").tag(AppRoute.home)
                Label("Library",  systemImage: "books.vertical.fill").tag(AppRoute.library)
                Label("Stats",    systemImage: "chart.bar.fill").tag(AppRoute.stats)
                Label("Settings", systemImage: "gearshape.fill").tag(AppRoute.setting)
            }
            .navigationTitle("Just3000")
            .tint(.brandPrimary)
        } detail: {
            NavigationStack {
                switch selectedRoute {
                    case .home:     HomeView()
                    case .library:  LibraryView()
                    case .stats:    StatsView()
                    case .setting:  SettingView()
                    default:        HomeView()
                }
            }
        }
    }
}

#Preview {
    SidebarLayoutView()
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
