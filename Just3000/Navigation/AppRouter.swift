import SwiftUI

struct AppRouter: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) {
                route in
                switch route {
                    case .splash:
                        SplashView(isPresented: .constant(true))
                    case .onboarding:
                        OnboardingView()
                    case .home:
                        HomeView()
                    case .library:
                        LibraryView()
                    case .practice:
                        PracticeView()
                    case .practiceResult:
                        PracticeResultView()
                    case .stats:
                        StatsView()
                    case .setting:
                        SettingView()
                }
            }
    }
}

extension View {
    func registerRoutes() -> some View {
        self.modifier(AppRouter())
    }
}
