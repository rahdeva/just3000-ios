import SwiftUI

struct PracticeResultData: Hashable {
    var correct:   Int
    var incorrect: Int
    var total:     Int
    var mastered:  Int
    var newSeen:   Int
    var streak:    Int
}

enum AppRoute: Hashable {
    case splash
    case onboarding
    case home
    case library
    case practice
    case practiceResult(PracticeResultData)
    case stats
    case setting
    case dataLab

    var title: String {
        switch self {
            case .splash:            return "Splash"
            case .onboarding:        return "Onboarding"
            case .home:              return "Home"
            case .library:           return "Library"
            case .practice:          return "Practice"
            case .practiceResult(_): return "Practice Result"
            case .stats:             return "Stats"
            case .setting:           return "Settings"
            case .dataLab:           return "DataLab"
        }
    }

    var icon: String {
        switch self {
            case .splash:            return "sparkles"
            case .onboarding:        return "figure.wave"
            case .home:              return "house"
            case .library:           return "books.vertical"
            case .practice:          return "play.circle"
            case .practiceResult(_): return "checkmark.circle"
            case .stats:             return "chart.bar"
            case .setting:           return "gearshape"
            case .dataLab:           return "flask"
        }
    }

    var selectedIcon: String {
        switch self {
            case .splash:            return "sparkles"
            case .onboarding:        return "figure.wave"
            case .home:              return "house.fill"
            case .library:           return "books.vertical.fill"
            case .practice:          return "play.circle.fill"
            case .practiceResult(_): return "checkmark.circle.fill"
            case .stats:             return "chart.bar.fill"
            case .setting:           return "gearshape.fill"
            case .dataLab:           return "flask.fill"
        }
    }
}
