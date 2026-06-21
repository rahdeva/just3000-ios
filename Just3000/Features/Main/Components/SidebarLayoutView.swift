import SwiftData
import SwiftUI

private let darkNavy = Color(red: 28 / 255, green: 28 / 255, blue: 36 / 255)

struct SidebarLayoutView: View {
    @State private var selectedRoute: AppRoute? = .home
    @State private var path = NavigationPath()
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            VStack(alignment: .center, spacing: 0) {
                Image(AppImages.splashLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 8)

                VStack(spacing: 12) {
                    sidebarRow(.home)
                    sidebarRow(.library)
                    sidebarRow(.stats)
                }
                .padding(.horizontal, 12)

                Spacer()

                Divider()
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)

                sidebarRow(.setting)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 24)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        } detail: {
            NavigationStack(path: $path) {
                selectedView
                    .registerRoutes(path: $path)
            }
        }
        .onChange(of: path) { _, newPath in
            columnVisibility = newPath.count > 0 ? .detailOnly : .automatic
        }
        .onChange(of: selectedRoute) { _, _ in
            path.removeLast(path.count)
        }
    }

    @ViewBuilder
    private func sidebarRow(_ route: AppRoute) -> some View {
        let isSelected = selectedRoute == route
        Button {
            selectedRoute = route
        } label: {
            HStack(spacing: 10) {
                Image(systemName: route.selectedIcon)
                    .font(
                        .system(
                            size: 16,
                            weight: isSelected ? .semibold : .regular
                        )
                    )
                    .frame(width: 22)
                Text(route.title)
                    .font(AppTypography.PlusJakartaSans.callout)
                    .fontWeight(isSelected ? .semibold : .regular)
                Spacer()
            }
            .foregroundStyle(
                isSelected ? Color(.brandPrimary) : darkNavy.opacity(0.55)
            )
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(
                        isSelected
                            ? Color(.brandPrimary).opacity(0.1) : Color.clear
                    )
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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
