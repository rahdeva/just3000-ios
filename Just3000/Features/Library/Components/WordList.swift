import SwiftUI

struct WordList: View {
    let words: [LibraryWord]
    let onSelect: (LibraryWord) -> Void

    var body: some View {
        if words.isEmpty {
            Text("No words match this filter.")
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            VStack(spacing: 0) {
                ForEach(Array(words.enumerated()), id: \.element.id) { index, word in
                    WordRow(word: word, isLast: index == words.count - 1) {
                        onSelect(word)
                    }
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    let vm = LibraryViewModel()
    WordList(words: vm.filtered(search: "", filter: .all, sort: .byRank), onSelect: { _ in })
        .padding()
        .background(Color(.systemGroupedBackground))
}
