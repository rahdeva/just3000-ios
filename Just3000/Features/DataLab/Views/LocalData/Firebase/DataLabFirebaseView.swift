import SwiftUI

struct DataLabFirebaseView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .firebase,
            about: "Google's real-time cloud platform. Includes Firestore (NoSQL document store), Realtime Database, Authentication with social providers, Cloud Storage, Crashlytics, and Analytics. Cross-platform Swift SDK with a generous free tier.",
            useCases: [
                "Real-time collaborative features",
                "Cross-platform apps (iOS + Android + Web)",
                "Authentication with social login (Google, Apple, etc.)",
                "Push notifications via Firebase Cloud Messaging"
            ],
            note: "Firebase requires adding the Firebase Swift SDK via Swift Package Manager and adding a GoogleService-Info.plist configuration file to the project."
        )
    }
}

#Preview {
    NavigationStack { DataLabFirebaseView() }
}
