enum AppRoute: Hashable {
    case splash
    case onboarding
    case home
    case library
    case practice
    case progress
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
            case .progress:
                return "/progress"
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
            case .progress:
                return "Progress"
            case .setting:
                return "Setting"
        }
    }
}
