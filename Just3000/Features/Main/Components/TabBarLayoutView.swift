import SwiftUI
import SwiftData

struct TabBarLayoutView: View {
    @State private var selectedTab: AppRoute = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack { HomeView() }
                .tabItem { Label("Home",     systemImage: "house") }
                .tag(AppRoute.home)

            NavigationStack { LibraryView() }
                .tabItem { Label("Library",  systemImage: "books.vertical") }
                .tag(AppRoute.library)

            NavigationStack { StatsView() }
                .tabItem { Label("Stats", systemImage: "chart.bar") }
                .tag(AppRoute.stats)

            NavigationStack { SettingView() }
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(AppRoute.setting)
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    TabBarLayoutView()
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
