import Foundation

// MARK: - Category

enum DataLabCategory: CaseIterable {
    case local
    case cloud

    var title: String {
        switch self {
        case .local:  return "Local Storage"
        case .cloud:  return "Cloud Storage"
        }
    }

    var icon: String {
        switch self {
        case .local:  return "externaldrive"
        case .cloud:  return "cloud"
        }
    }
}

// MARK: - Storage Type

enum DataLabStorageType: String, CaseIterable, Identifiable {

    // Local — available
    case userDefaults = "UserDefaults"
    case fileStorage  = "File Storage"
    case keychain     = "Keychain"

    // Local — coming soon
    case swiftData    = "SwiftData"
    case coreData     = "Core Data"
    case sqlite       = "SQLite"
    case realm        = "Realm"

    // Cloud — coming soon
    case cloudKit     = "CloudKit"
    case firebase     = "Firebase"
    case supabase     = "Supabase"
    case restAPI      = "REST API"
    case graphQL      = "GraphQL"

    var id: String { rawValue }

    var isAvailable: Bool {
        switch self {
        case .userDefaults, .fileStorage, .keychain: return true
        default: return false
        }
    }

    var category: DataLabCategory {
        switch self {
        case .userDefaults, .fileStorage, .keychain,
             .swiftData, .coreData, .sqlite, .realm:
            return .local
        case .cloudKit, .firebase, .supabase, .restAPI, .graphQL:
            return .cloud
        }
    }

    var icon: String {
        switch self {
        case .userDefaults: return "slider.horizontal.3"
        case .fileStorage:  return "folder"
        case .keychain:     return "lock.shield"
        case .swiftData:    return "swift"
        case .coreData:     return "cylinder.split.1x2"
        case .sqlite:       return "tablecells"
        case .realm:        return "hexagon"
        case .cloudKit:     return "icloud"
        case .firebase:     return "flame"
        case .supabase:     return "bolt"
        case .restAPI:      return "network"
        case .graphQL:      return "arrow.triangle.branch"
        }
    }

    var subtitle: String {
        switch self {
        case .userDefaults: return "Key-value app preferences"
        case .fileStorage:  return "JSON files on disk"
        case .keychain:     return "Secure credential storage"
        case .swiftData:    return "Apple's modern ORM"
        case .coreData:     return "Apple's persistence framework"
        case .sqlite:       return "Embedded relational database"
        case .realm:        return "Mobile-first object database"
        case .cloudKit:     return "Apple's cloud database"
        case .firebase:     return "Google realtime database"
        case .supabase:     return "Open-source Firebase alternative"
        case .restAPI:      return "HTTP + server-side database"
        case .graphQL:      return "Flexible query language for APIs"
        }
    }

    var scenario: DataLabScenario {
        switch self {
        case .userDefaults: return .preferences
        case .keychain:     return .session
        default:            return .wordCRUD
        }
    }
}
