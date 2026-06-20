import SwiftUI

struct DataLabRealmView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .realm,
            about: "A cross-platform mobile-first object database by MongoDB. Stores data as Swift objects directly — no ORM mapping or SQL needed. Supports live reactive queries with change notifications, offline-first architecture, and Atlas Device Sync for cloud backup.",
            useCases: [
                "Real-time reactive data in SwiftUI",
                "Offline-first apps that sync when back online",
                "Complex object models without SQL schemas",
                "Cross-platform shared data (iOS + Android)"
            ],
            note: "Realm can sync with MongoDB Atlas via Atlas Device Sync, providing automatic conflict resolution and cross-device real-time updates."
        )
    }
}

#Preview {
    NavigationStack { DataLabRealmView() }
}
