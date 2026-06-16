enum AppRoute: Hashable {
    case splash
    case onboarding
    case home
    case library
    case practice
    case practiceResult
    case stats
    case setting
}

extension AppRoute {
    var path: String {
        switch self {
            case .splash:
                return "/splash"
            case .onboarding:
                return "/onboarding"
            case .home:
                return "/home"
            case .library:
                return "/library"
            case .practice:
                return "/practice"
            case .practiceResult:
                return "/practice-result"
            case .stats:
                return "/stats"
            case .setting:
                return "/setting"
        }
    }

    var title: String {
        switch self {
            case .splash:
                return "Splash"
            case .onboarding:
                return "Onboarding"
            case .home:
                return "Home"
            case .library:
                return "Library"
            case .practice:
                return "Practice"
            case .practiceResult:
                return "Practice Result"
            case .stats:
                return "Stats"
            case .setting:
                return "Setting"
        }
    }
}
