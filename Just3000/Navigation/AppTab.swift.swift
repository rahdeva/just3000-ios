import SwiftUI

enum AppTab: Hashable {
    case home
    case library
    case stats
    case setting
    case dataLab

    var title: String {
        switch self {
            case .home:
                return "Home"
            case .library:
                return "Library"
            case .stats:
                return "Stats"
            case .setting:
                return "Setting"
            case .dataLab:
                return "DataLab"
        }
    }

    var icon: String {
        switch self {
            case .home:
                return "house"
            case .library:
                return "books.vertical"
            case .stats:
                return "chart.bar"
            case .setting:
                return "gearshape"
            case .dataLab:
                return "flask"
        }
    }

    var selectedIcon: String {
        switch self {
            case .home:
                return "house.fill"
            case .library:
                return "books.vertical.fill"
            case .stats:
                return "chart.bar.fill"
            case .setting:
                return "gearshape.fill"
            case .dataLab:
                return "flask.fill"
        }
    }
}
