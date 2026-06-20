import SwiftUI

struct DataLabWordRow: View {
    let word: WordItem
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(word.word)
                    .font(.headline)
                Text(word.meaning)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Button { onEdit() } label: {
                Image(systemName: "pencil")
                    .foregroundStyle(Color.accentColor)
            }
            .buttonStyle(.plain)

            Button { onDelete() } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
