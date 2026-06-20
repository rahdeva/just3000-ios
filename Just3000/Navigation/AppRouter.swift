import SwiftUI

struct AppRouter: ViewModifier {
    @Binding var path: NavigationPath

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .splash:
                    SplashView(isPresented: .constant(true))

                case .onboarding:
                    OnboardingView()

                case .home:
                    HomeView(path: $path)

                case .library:
                    LibraryView(path: $path)

                case .practice:
                    PracticeView(path: $path)

                case .practiceResult(let data):
                    PracticeResultView(
                        path:      $path,
                        correct:   data.correct,
                        incorrect: data.incorrect,
                        total:     data.total,
                        mastered:  data.mastered,
                        newSeen:   data.newSeen,
                        streak:    data.streak
                    )

                case .stats:
                    StatsView(path: $path)

                case .setting:
                    SettingView(path: $path)

                case .dataLab:
                    DataLabView(path: $path)
                }
            }
    }
}

extension View {
    func registerRoutes(path: Binding<NavigationPath>) -> some View {
        self.modifier(AppRouter(path: path))
    }
}
