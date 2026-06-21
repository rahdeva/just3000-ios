import SwiftUI
import SwiftData

struct TabBarLayoutView: View {
    @State private var selectedTab: AppRoute = .home
    @State private var homePath = NavigationPath()
    @State private var libraryPath = NavigationPath()
    @State private var statsPath = NavigationPath()
    @State private var settingPath = NavigationPath()
    @State private var dataLabPath = NavigationPath()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homePath) {
                HomeView(path: $homePath)
                    .registerRoutes(path: $homePath)
            }
            .tabItem { Label(AppRoute.home.title, systemImage: AppRoute.home.icon) }
            .tag(AppRoute.home)

            NavigationStack(path: $libraryPath) {
                LibraryView(path: $libraryPath)
                    .registerRoutes(path: $libraryPath)
            }
            .tabItem { Label(AppRoute.library.title, systemImage: AppRoute.library.icon) }
            .tag(AppRoute.library)

            NavigationStack(path: $statsPath) {
                StatsView(path: $statsPath)
                    .registerRoutes(path: $statsPath)
            }
            .tabItem { Label(AppRoute.stats.title, systemImage: AppRoute.stats.icon) }
            .tag(AppRoute.stats)

            NavigationStack(path: $settingPath) {
                SettingView(path: $settingPath)
                    .registerRoutes(path: $settingPath)
            }
            .tabItem { Label(AppRoute.setting.title, systemImage: AppRoute.setting.icon) }
            .tag(AppRoute.setting)

            NavigationStack(path: $dataLabPath) {
                DataLabView(path: $dataLabPath)
                    .registerRoutes(path: $dataLabPath)
            }
            .tabItem { Label(AppRoute.dataLab.title, systemImage: AppRoute.dataLab.icon) }
            .tag(AppRoute.dataLab)
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    TabBarLayoutView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
