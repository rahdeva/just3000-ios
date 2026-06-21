import SwiftUI

struct DataLabFileStorageView: View {
    @State private var vm = DataLabViewModel(storageType: .fileStorage)

    private var filePath: String {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent("datalab_words.json").path
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                infoCard
                detailsCard
                createEditSection
                wordListSection
                Divider().padding(.horizontal)
                DataLabLogSection(vm: vm)
            }
            .padding(.vertical)
        }
        .navigationTitle("File Storage")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.refreshData() }
    }

    // MARK: - Info Card

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("About File Storage", systemImage: "info.circle")
                .font(.headline)
            Text("Reads and writes JSON files in the app's Documents directory. Any Codable type can be persisted. Data survives app restarts. Uses atomic writes to prevent corruption.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            HStack(spacing: 8) {
                tag("Offline Cache")
                tag("CRUD")
                tag("JSON")
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
            detail(label: "Service",  value: "FileStorageService")
            detail(label: "Repo",     value: "FileWordRepository")
            detail(label: "File",     value: "datalab_words.json")
            detail(label: "Location", value: "Documents/")
            detail(label: "Format",   value: "[WordItem] → JSON Array")
            detail(label: "Write",    value: ".atomic (safe)")
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
            }
            .padding(.horizontal)

            if vm.words.isEmpty {
                Text("No words yet. Create one above.")
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
    NavigationStack { DataLabFileStorageView() }
}
