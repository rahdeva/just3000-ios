import Foundation

struct DataLabResult: Identifiable {
    let id = UUID()
    let timestamp: Date
    let operation: String
    let success: Bool
    let detail: String

    init(operation: String, success: Bool, detail: String) {
        self.timestamp = Date()
        self.operation = operation
        self.success = success
        self.detail = detail
    }
}
