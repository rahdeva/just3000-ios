import CloudKit
import Foundation

/// Layer 2: Jembatan antara ViewModel dan CloudKitWordService.
/// Bertugas menangkap error mentah dari Service dan mengubahnya
/// menjadi CloudKitWordError yang lebih deskriptif untuk ditampilkan di log.
final class CloudKitWordRepository {

    private let service: CloudKitWordService

    init(service: CloudKitWordService = CloudKitWordService()) {
        self.service = service
    }

    // MARK: - Account

    func checkAccountStatus() async throws -> CKAccountStatus {
        // Error dari sini dibiarkan naik — ViewModel menanganinya secara silent
        try await service.checkAccountStatus()
    }

    // MARK: - CRUD

    func readAll() async throws -> [WordItem] {
        do {
            return try await service.fetchAll()
        } catch {
            throw CloudKitWordError.from(error)
        }
    }

    func create(_ word: WordItem) async throws {
        do {
            try await service.create(word)
        } catch {
            throw CloudKitWordError.from(error)
        }
    }

    func update(_ word: WordItem) async throws {
        do {
            try await service.update(word)
        } catch {
            throw CloudKitWordError.from(error)
        }
    }

    func delete(id: UUID) async throws {
        do {
            try await service.delete(id: id)
        } catch {
            throw CloudKitWordError.from(error)
        }
    }
}
