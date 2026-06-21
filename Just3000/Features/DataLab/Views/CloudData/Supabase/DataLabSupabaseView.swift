import SwiftUI

struct DataLabSupabaseView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .supabase,
            about: "An open-source Firebase alternative built on PostgreSQL. Offers a full SQL database, real-time subscriptions via WebSockets, authentication, edge functions, and file storage. Can be self-hosted or used as a managed cloud service.",
            useCases: [
                "Apps needing full SQL and relational data",
                "Real-time data subscriptions (e.g. chat, feeds)",
                "Row-level security for multi-tenant apps",
                "Open-source alternative — avoid vendor lock-in"
            ],
            note: "Supabase provides an official Swift client library and can auto-generate type-safe Swift models from your database schema using its CLI."
        )
    }
}

#Preview {
    NavigationStack { DataLabSupabaseView() }
}
