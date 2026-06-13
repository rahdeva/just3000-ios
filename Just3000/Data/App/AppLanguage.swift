enum AppLanguage: String, CaseIterable {
    case english = "EN"
    case indonesian = "ID"

    var label: String {
        switch self {
            case .english: "English"
            case .indonesian: "Bahasa Indonesia"
        }
    }

    var flag: String {
        switch self {
            case .english: "🇺🇸"
            case .indonesian: "🇮🇩"
        }
    }
}
