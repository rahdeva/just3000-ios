import CloudKit
import Foundation

/// Error types spesifik untuk operasi CloudKit Word.
/// Dipakai oleh CloudKitWordRepository untuk memetakan CKError
/// menjadi pesan yang lebih mudah dipahami di operation log.
enum CloudKitWordError: LocalizedError {
    case quotaExceeded
    case networkUnavailable
    case notAuthenticated
    case unknownItem
    case permissionFailure
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .quotaExceeded:
            return "Quota iCloud penuh. Kosongkan ruang lalu coba lagi."
        case .networkUnavailable:
            return "Tidak ada koneksi internet. Periksa jaringan dan coba lagi."
        case .notAuthenticated:
            return "Belum login iCloud. Buka Settings > Apple Account."
        case .unknownItem:
            return "Record tidak ditemukan — mungkin sudah dihapus."
        case .permissionFailure:
            return "Akses ditolak. Periksa security roles di CloudKit Dashboard."
        case .unknown(let error):
            return "CloudKit error: \(error.localizedDescription)"
        }
    }

    /// Memetakan CKError mentah menjadi CloudKitWordError yang lebih spesifik.
    static func from(_ error: Error) -> CloudKitWordError {
        guard let ckError = error as? CKError else { return .unknown(error) }
        switch ckError.code {
        case .quotaExceeded:
            return .quotaExceeded
        case .networkFailure, .networkUnavailable:
            return .networkUnavailable
        case .notAuthenticated:
            return .notAuthenticated
        case .unknownItem:
            return .unknownItem
        case .permissionFailure:
            return .permissionFailure
        default:
            return .unknown(ckError)
        }
    }
}
