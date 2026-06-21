import SwiftUI

struct DataLabGraphQLView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .graphQL,
            about: "A query language and runtime for APIs developed by Meta. Clients specify exactly what data they need in a single request, eliminating over-fetching and under-fetching. Apollo iOS is the most popular Swift client, providing code generation from your schema.",
            useCases: [
                "Complex UIs needing data from multiple resources",
                "Reducing network payload size on slow connections",
                "Type-safe API contracts shared between client and server",
                "Real-time subscriptions for live data"
            ],
            note: "Apollo iOS generates Swift types automatically from your GraphQL schema and queries, giving you compile-time safety for all data operations."
        )
    }
}

#Preview {
    NavigationStack { DataLabGraphQLView() }
}
