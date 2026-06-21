import CloudKit
import Foundation

/// Layer 1: Komunikasi langsung dengan CloudKit.
/// Hanya bertanggung jawab mapping WordItem ↔ CKRecord dan memanggil CloudKit API.
/// Error dibiarkan naik ke CloudKitWordRepository untuk di-map.
final class CloudKitWordService {

    // Public database dipakai untuk master vocabulary (bukan data progress per-user).
    // Keuntungan: quota jauh lebih besar, read tidak butuh login iCloud.
    // Write (create/update/delete) tetap butuh user login.
    private let container = CKContainer(identifier: "iCloud.com.adeventures.Just3000")

    private var database: CKDatabase {
        container.publicCloudDatabase
    }

    /// Cek status akun iCloud — diperlukan sebelum write operations.
    func checkAccountStatus() async throws -> CKAccountStatus {
        try await container.accountStatus()
    }

    /// Ambil semua Word, diurutkan dari yang paling baru (createdAt descending).
    func fetchAll() async throws -> [WordItem] {
        let query = CKQuery(recordType: "Word", predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        let (results, _) = try await database.records(matching: query)
        return results.compactMap { _, result in
            (try? result.get())?.toWordItem()
        }
    }

    /// Simpan Word baru. UUID dipakai sebagai CKRecord name agar
    /// update/delete bisa reconstruct recordID tanpa field tambahan.
    func create(_ word: WordItem) async throws {
        let recordID = CKRecord.ID(recordName: word.id.uuidString)
        let record = CKRecord(recordType: "Word", recordID: recordID)
        record.apply(word)
        try await database.save(record)
    }

    /// Fetch record lama lalu patch field-nya — CloudKit butuh record asli untuk conflict resolution.
    func update(_ word: WordItem) async throws {
        let recordID = CKRecord.ID(recordName: word.id.uuidString)
        let existing = try await database.record(for: recordID)
        existing.apply(word)
        try await database.save(existing)
    }

    func delete(id: UUID) async throws {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        _ = try await database.deleteRecord(withID: recordID)
    }
}

// MARK: - CKRecord ↔ WordItem

private extension CKRecord {
    /// Konversi CKRecord ke WordItem. Nil jika field wajib tidak ada.
    func toWordItem() -> WordItem? {
        guard
            let text    = self["text"] as? String,
            let meaning = self["meaning"] as? String
        else { return nil }
        return WordItem(
            id:        UUID(uuidString: recordID.recordName) ?? UUID(),
            word:      text,
            meaning:   meaning,
            createdAt: self["createdAt"] as? Date ?? Date()
        )
    }

    /// Set field dari WordItem ke CKRecord (dipakai saat create & update).
    func apply(_ word: WordItem) {
        self["text"]      = word.word      as CKRecordValue
        self["meaning"]   = word.meaning   as CKRecordValue
        self["createdAt"] = word.createdAt as CKRecordValue
    }
}
