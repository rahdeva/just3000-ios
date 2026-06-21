import SwiftUI

// Shared operation log shown at the bottom of every lab view.
// Receives the ViewModel directly — @Observable tracks vm.results access automatically.
struct DataLabLogSection: View {
    let vm: DataLabViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Operation Log", systemImage: "list.bullet.clipboard")
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
                Text("Operations will appear here after you perform an action.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                LazyVStack(spacing: 6) {
                    ForEach(vm.results) { result in
                        LogRow(result: result)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Log Row

private struct LogRow: View {
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
