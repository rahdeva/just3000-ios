import SwiftUI

struct DataLabUserDefaultsView: View {
    @State private var vm = DataLabViewModel(storageType: .userDefaults)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                infoCard
                detailsCard
                actionsSection
                Divider().padding(.horizontal)
                DataLabLogSection(vm: vm)
            }
            .padding(.vertical)
        }
        .navigationTitle("UserDefaults")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.refreshData() }
    }

    // MARK: - Info Card

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("About UserDefaults", systemImage: "info.circle")
                .font(.headline)
            Text("A lightweight key-value store managed by the OS. Values persist automatically between app launches. Data is stored unencrypted — never put passwords or tokens here.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            HStack(spacing: 8) {
                tag("Preferences")
                tag("Settings")
                tag("Feature Flags")
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // MARK: - Implementation Details

    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Implementation Details", systemImage: "doc.text.magnifyingglass")
                .font(.headline)
            detail(label: "Class",    value: "UserDefaultsStorage")
            detail(label: "Suite",    value: "com.just3000.datalab")
            detail(label: "Key",      value: "datalab.themeMode")
            detail(label: "Encoding", value: "JSONEncoder (Codable)")
            detail(label: "Type",     value: "AppThemeMode : String")
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // MARK: - Actions

    private var actionsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Actions")
                .font(.headline)
                .padding(.horizontal)
            DataLabPreferenceForm(vm: vm)
        }
    }

    // MARK: - Helpers

    private func detail(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 72, alignment: .leading)
            Text(value)
                .font(.caption.monospaced())
        }
    }

    private func tag(_ text: String) -> some View {
        Text(text)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(Color.accentColor.opacity(0.1))
            .foregroundStyle(Color.accentColor)
            .clipShape(Capsule())
    }
}

#Preview {
    NavigationStack { DataLabUserDefaultsView() }
}
