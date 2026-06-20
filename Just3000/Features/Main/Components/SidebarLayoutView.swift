import SwiftUI
import SwiftData

struct SidebarLayoutView: View {
    @State private var selectedRoute: AppRoute? = .home
    @State private var path = NavigationPath()

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedRoute) {
                Label(
                    AppRoute.home.title,
                    systemImage: AppRoute.home.selectedIcon
                )
                .tag(AppRoute.home)

                Label(
                    AppRoute.library.title,
                    systemImage: AppRoute.library.selectedIcon
                )
                .tag(AppRoute.library)

                Label(
                    AppRoute.stats.title,
                    systemImage: AppRoute.stats.selectedIcon
                )
                .tag(AppRoute.stats)

                Label(
                    AppRoute.setting.title,
                    systemImage: AppRoute.setting.selectedIcon
                )
                .tag(AppRoute.setting)

//                Label(
//                    AppRoute.dataLab.title,
//                    systemImage: AppRoute.dataLab.selectedIcon
//                )
//                .tag(AppRoute.dataLab)
            }
            .navigationTitle("Just3000")
            .tint(.brandPrimary)
        } detail: {
            NavigationStack(path: $path) {
                selectedView
                    .registerRoutes(path: $path)
            }
        }
        .onChange(of: selectedRoute) { _, _ in
            path.removeLast(path.count)
        }
    }

    @ViewBuilder
    private var selectedView: some View {
        switch selectedRoute {
        case .home:
            HomeView(path: $path)

        case .library:
            LibraryView(path: $path)

        case .stats:
            StatsView(path: $path)

        case .setting:
            SettingView(path: $path)

        case .dataLab:
            DataLabView(path: $path)

        case .splash:
            SplashView(isPresented: .constant(true))

        case .onboarding:
            OnboardingView()

        case .practice:
            PracticeView(path: $path)

        case .practiceResult(_):
            HomeView(path: $path)

        case .none:
            HomeView(path: $path)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    SidebarLayoutView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
