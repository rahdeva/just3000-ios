import SwiftUI
import SwiftData

struct SidebarLayoutView: View {
    @Binding var path: NavigationPath
    @State private var selectedRoute: AppRoute? = .home

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedRoute) {
                Label("Home", systemImage: "house")
                    .tag(AppRoute.home)

                Label("Library", systemImage: "books.vertical")
                    .tag(AppRoute.library)

                Label("Practice", systemImage: "pencil")
                    .tag(AppRoute.practice)

                Label("Progress", systemImage: "chart.bar")
                    .tag(AppRoute.progress)

                Label("Setting", systemImage: "gearshape")
                    .tag(AppRoute.setting)
            }
            .navigationTitle("Just3000")
        } detail: {
            switch selectedRoute {
            case .home:
                HomeView(path: $path)
            case .library:
                LibraryView(path: $path)
            case .practice:
                PracticeView(path: $path)
            case .progress:
                ProgressView(path: $path)
            case .setting:
                SettingView()
            default:
                HomeView(path: $path)
            }
        }
    }
}

#Preview {
    SidebarLayoutView(path: .constant(NavigationPath()))
        .environment(GeneralViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
}
