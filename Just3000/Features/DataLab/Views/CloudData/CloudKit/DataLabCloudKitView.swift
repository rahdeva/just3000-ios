import SwiftUI

struct DataLabCloudKitView: View {
    @State private var vm = DataLabViewModel(storageType: .cloudKit)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                infoCard
                iCloudStatusCard
                detailsCard
                createEditSection
                wordListSection
                Divider().padding(.horizontal)
                DataLabLogSection(vm: vm)
            }
            .padding(.vertical)
        }
        .navigationTitle("CloudKit")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.refreshData() }
        .overlay {
            if vm.isLoading {
                ProgressView()
                    .padding(20)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    // MARK: - Info Card

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("About CloudKit", systemImage: "info.circle")
                .font(.headline)
            Text("Apple's managed cloud backend tied to iCloud. Records are stored privately per user with no server code required. Uses the UUID as the CKRecord name, enabling deterministic create, update, and delete without extra storage.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            HStack(spacing: 8) {
                tag("iCloud Sync")
                tag("Private DB")
                tag("CRUD")
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // MARK: - iCloud Status Card

    @ViewBuilder
    private var iCloudStatusCard: some View {
        if let message = vm.iCloudStatusMessage {
            HStack(spacing: 10) {
                Image(systemName: vm.isICloudAvailable ? "checkmark.icloud.fill" : "exclamationmark.icloud.fill")
                    .foregroundStyle(vm.isICloudAvailable ? .green : .orange)
                    .font(.title3)
                VStack(alignment: .leading, spacing: 2) {
                    Text("iCloud Status")
                        .font(.caption.weight(.semibold))
                    Text(message)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
        }
    }

    // MARK: - Implementation Details

    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Implementation Details", systemImage: "doc.text.magnifyingglass")
                .font(.headline)
            detail(label: "Service",   value: "CloudKitWordService")
            detail(label: "Container", value: "iCloud.com.adeventures.Just3000")
            detail(label: "Database",  value: "privateCloudDatabase")
            detail(label: "Type",      value: "CKRecord (\"Word\")")
            detail(label: "ID",        value: "word.id.uuidString → CKRecord.ID")
            detail(label: "Fields",    value: "text, meaning, createdAt")
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // MARK: - Create / Edit

    private var createEditSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(vm.editingWord == nil ? "Create Word" : "Edit Word")
                .font(.headline)
                .padding(.horizontal)
            DataLabWordForm(vm: vm)
        }
    }

    // MARK: - Word List

    private var wordListSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Stored Words (\(vm.words.count))")
                    .font(.headline)
                Spacer()
                Button("Refresh") { vm.loadWords() }
                    .font(.subheadline)
                    .disabled(vm.isLoading)
            }
            .padding(.horizontal)

            if vm.words.isEmpty {
                Text(vm.iCloudAccountStatus == nil ? "Loading…" : "No words yet. Create one above.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(vm.words) { word in
                        DataLabWordRow(word: word) {
                            vm.startEditing(word)
                        } onDelete: {
                            vm.deleteWord(word)
                        }
                        Divider().padding(.horizontal)
                    }
                }
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            }
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
    NavigationStack { DataLabCloudKitView() }
}
