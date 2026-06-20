import SwiftUI

struct DataLabRESTAPIView: View {
    var body: some View {
        DataLabComingSoonContent(
            type: .restAPI,
            about: "A standard architectural style where the iOS app communicates with a backend server over HTTP using CRUD operations (GET, POST, PUT, DELETE). The server can use any database. Auth is typically handled via JWT tokens stored in the Keychain.",
            useCases: [
                "Apps with a custom backend or existing API",
                "Full control over server-side business logic",
                "Integration with any database or service",
                "Multi-platform apps sharing one backend"
            ],
            note: "iOS uses URLSession for HTTP requests. Codable structs map JSON responses to Swift types automatically. Alamofire is a popular third-party alternative with a cleaner API."
        )
    }
}

#Preview {
    NavigationStack { DataLabRESTAPIView() }
}
