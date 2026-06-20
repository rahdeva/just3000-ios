import Foundation

enum DataLabScenario: Equatable {
    case preferences
    case wordCRUD
    case session

    var title: String {
        switch self {
        case .preferences: return "Preferences Lab"
        case .wordCRUD:    return "Word CRUD Lab"
        case .session:     return "Session Lab"
        }
    }

    // Short label used in the landing page badge
    var badgeLabel: String {
        switch self {
        case .preferences: return "Preferences"
        case .wordCRUD:    return "Word CRUD"
        case .session:     return "Session"
        }
    }

    var description: String {
        switch self {
        case .preferences:
            return "Save, read, and reset app preferences (theme mode) using UserDefaults."
        case .wordCRUD:
            return "Create, read, update, and delete WordItem entries using File Storage."
        case .session:
            return "Save and read a secure user session (access token) using Keychain."
        }
    }
}
