import SwiftUI

struct DataLabCloudKitView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .cloudKit,
            about: "Apple's managed cloud backend tied to iCloud. Records are private per user or shared publicly. Storage quota is included free with the Apple Developer Program. No server-side code needed — Apple manages all infrastructure.",
            useCases: [
                "Cross-device sync for Apple users",
                "iCloud-backed app documents and data",
                "Sharing records between users",
                "Zero-cost backend for Apple-only apps"
            ],
            note: "CloudKit integrates directly with SwiftData and Core Data for automatic cloud sync. CKSyncEngine (iOS 17+) simplifies custom sync logic significantly."
        )
    }
}

#Preview {
    NavigationStack { DataLabCloudKitView() }
}
