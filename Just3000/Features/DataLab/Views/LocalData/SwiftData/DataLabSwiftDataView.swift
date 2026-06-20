import SwiftUI

struct DataLabSwiftDataView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .swiftData,
            about: "Apple's modern ORM introduced in iOS 17. Uses the @Model macro to automatically generate a database schema from Swift classes. Backed by Core Data under the hood, but with a dramatically cleaner, SwiftUI-native API.",
            useCases: [
                "Complex data models with relationships",
                "iCloud sync via CloudKit integration",
                "SwiftUI-native binding with @Query",
                "Replacing Core Data with far less boilerplate"
            ],
            note: "SwiftData is the recommended path for new iOS 17+ apps."
        )
    }
}

#Preview {
    NavigationStack { DataLabSwiftDataView() }
}
