import SwiftUI
import SwiftData

struct TabBarLayoutView: View {
    @Binding var path: NavigationPath
    @State private var selectedTab: AppRoute = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(path: $path)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(AppRoute.home)

            LibraryView(path: $path)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
                .tag(AppRoute.library)

            ProgressView(path: $path)
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }
                .tag(AppRoute.progress)

            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }
                .tag(AppRoute.setting)
        }
    }
}

#Preview {
    TabBarLayoutView(path: .constant(NavigationPath()))
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
