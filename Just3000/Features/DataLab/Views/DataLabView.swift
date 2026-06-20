import SwiftUI

struct DataLabView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                introCard
                categorySection(for: .local)
                categorySection(for: .cloud)
            }
            .padding()
        }
        .navigationTitle("DataLab")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Intro

    private var introCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Storage Playground")
                .font(.title3.bold())
            Text("Explore and compare data storage technologies. Tap any item to learn more or start experimenting.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Category Section

    private func categorySection(for category: DataLabCategory) -> some View {
        let types = DataLabStorageType.allCases.filter { $0.category == category }

        return VStack(alignment: .leading, spacing: 12) {
            Label(category.title, systemImage: category.icon)
                .font(.headline)

            VStack(spacing: 0) {
                ForEach(Array(types.enumerated()), id: \.element.id) { index, type in
                    NavigationLink(destination: destinationView(for: type)) {
                        StorageRowContent(type: type)
                    }
                    .buttonStyle(.plain)

                    if index < types.count - 1 {
                        Divider().padding(.leading, 58)
                    }
                }
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    // MARK: - Destination Router

    @ViewBuilder
    private func destinationView(for type: DataLabStorageType) -> some View {
        switch type {
        // Local — Phase 1
        case .userDefaults: DataLabUserDefaultsView()
        case .fileStorage:  DataLabFileStorageView()
        case .keychain:     DataLabKeychainView()
        // Local — Phase 2
        case .swiftData:    DataLabSwiftDataView()
        case .coreData:     DataLabCoreDataView()
        case .sqlite:       DataLabSQLiteView()
        case .realm:        DataLabRealmView()
        // Cloud — Phase 3
        case .cloudKit:     DataLabCloudKitView()
        case .firebase:     DataLabFirebaseView()
        case .supabase:     DataLabSupabaseView()
        case .restAPI:      DataLabRESTAPIView()
        case .graphQL:      DataLabGraphQLView()
        }
    }
}

// MARK: - Row Content

private struct StorageRowContent: View {
    let type: DataLabStorageType

    var body: some View {
        HStack(spacing: 14) {
            iconView
            labelStack
            Spacer()
            trailingBadge
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }

    private var iconView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(type.isAvailable ? Color.accentColor.opacity(0.12) : Color(.systemGray5))
                .frame(width: 40, height: 40)
            Image(systemName: type.icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(type.isAvailable ? Color.accentColor : Color(.systemGray2))
        }
    }

    private var labelStack: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(type.rawValue)
                .font(.body.weight(.medium))
                .foregroundStyle(type.isAvailable ? .primary : .secondary)
            Text(type.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var trailingBadge: some View {
        if type.isAvailable {
            HStack(spacing: 8) {
                Text(type.scenario.badgeLabel)
                    .font(.caption2.weight(.semibold))
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(Color.accentColor.opacity(0.1))
                    .foregroundStyle(Color.accentColor)
                    .clipShape(Capsule())
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color(.systemGray3))
            }
        } else {
            HStack(spacing: 8) {
                Text("Phase \(type.phase)")
                    .font(.caption2.weight(.semibold))
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(Color(.systemGray5))
                    .foregroundStyle(Color(.systemGray))
                    .clipShape(Capsule())
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color(.systemGray4))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DataLabView()
    }
}
