import SwiftUI

struct DataLabLabView: View {
    let storageType: DataLabStorageType

    @State private var vm: DataLabViewModel

    init(storageType: DataLabStorageType) {
        self.storageType = storageType
        self._vm = State(initialValue: DataLabViewModel(storageType: storageType))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                scenarioInfo
                Divider().padding(.horizontal)
                formSection
                wordList
                Divider().padding(.horizontal)
                resultLog
            }
            .padding(.vertical)
        }
        .navigationTitle(storageType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.refreshData() }
    }

    // MARK: - Scenario Info

    private var scenarioInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(vm.scenario.title, systemImage: storageType.icon)
                .font(.headline)
            Text(vm.scenario.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }

    // MARK: - Form Section

    private var formSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Actions")
                .font(.headline)
                .padding(.horizontal)

            switch vm.scenario {
            case .preferences:
                DataLabPreferenceForm(vm: vm)
            case .wordCRUD:
                DataLabWordForm(vm: vm)
            case .session:
                DataLabSessionForm(vm: vm)
            }
        }
    }

    // MARK: - Word List (Word CRUD only)

    @ViewBuilder
    private var wordList: some View {
        if vm.scenario == .wordCRUD {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Words (\(vm.words.count))")
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
    }

    // MARK: - Operation Log

    private var resultLog: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Operation Log")
                    .font(.headline)
                Spacer()
                if !vm.results.isEmpty {
                    Button("Clear") { vm.results = [] }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)

            if vm.results.isEmpty {
                Text("Operations will appear here.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                LazyVStack(spacing: 6) {
                    ForEach(vm.results) { result in
                        DataLabResultRow(result: result)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Result Row

private struct DataLabResultRow: View {
    let result: DataLabResult

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: result.success ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(result.success ? .green : .red)
                .font(.subheadline)

            VStack(alignment: .leading, spacing: 2) {
                Text(result.operation)
                    .font(.subheadline.weight(.medium))
                Text(result.detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(result.timestamp, style: .time)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack {
        DataLabLabView(storageType: .fileStorage)
    }
}
