import SwiftUI

struct DataLabKeychainView: View {
    @State private var vm = DataLabViewModel(storageType: .keychain)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                infoCard
                detailsCard
                sessionSection
                Divider().padding(.horizontal)
                DataLabLogSection(vm: vm)
            }
            .padding(.vertical)
        }
        .navigationTitle("Keychain")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.refreshData() }
    }

    // MARK: - Info Card

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("About Keychain", systemImage: "info.circle")
                .font(.headline)
            Text("Apple's secure credential vault managed at the OS level. Data is encrypted, survives app deletion, and can be scoped to biometrics or a passcode. Uses the Security framework C API under the hood.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            HStack(spacing: 8) {
                tag("Tokens")
                tag("Passwords")
                tag("Encrypted")
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
            detail(label: "Storage",   value: "KeychainStorage")
            detail(label: "Repo",      value: "KeychainAuthSessionRepository")
            detail(label: "Item class",value: "kSecClassGenericPassword")
            detail(label: "Service",   value: "com.just3000.datalab")
            detail(label: "Account",   value: "datalab.session")
            detail(label: "Encoding",  value: "JSONEncoder → Data")
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // MARK: - Session

    private var sessionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Session")
                .font(.headline)
                .padding(.horizontal)
            DataLabSessionForm(vm: vm)
        }
    }

    // MARK: - Helpers

    private func detail(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 82, alignment: .leading)
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
    NavigationStack { DataLabKeychainView() }
}
