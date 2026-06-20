import Foundation

struct UserSession: Codable {
    var accessToken: String
    var refreshToken: String
    var expiresAt: Date?
}
