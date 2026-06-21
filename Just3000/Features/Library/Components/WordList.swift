import SwiftUI

struct WordList: View {
    let words: [LibraryWord]
    let onSelect: (LibraryWord) -> Void

    var body: some View {
        if words.isEmpty {
            Text("No words match this filter.")
                .font(AppTypography.PlusJakartaSans.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .wordListCard()
        } else {
            LazyVStack(spacing: 0) {
                ForEach(words) { word in
                    WordRow(word: word, isLast: word.id == words.last?.id) {
                        onSelect(word)
                    }
                }
            }
            .wordListCard()
        }
    }
}

private extension View {
    func wordListCard() -> some View {
        self
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.primary, lineWidth: 1.5)
            }
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.primary)
                    .offset(x: 4, y: 4)
            }
    }
}

#Preview {
    let vm = LibraryViewModel()
    WordList(words: vm.filtered(search: "", filter: .all, sort: .byRank), onSelect: { _ in })
        .padding()
        .background(Color(.appBackground))
}
