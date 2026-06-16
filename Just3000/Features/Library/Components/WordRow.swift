import SwiftUI

struct WordRow: View {
    let word: LibraryWord
    let isLast: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text("#\(word.rank)")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .frame(minWidth: 36, alignment: .leading)

                VStack(alignment: .leading, spacing: 1) {
                    Text(word.word)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.primary)
                    Text(word.pos)
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                        .italic()
                }

                Spacer()

                StageBadge(stage: word.stage)

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .contentShape(Rectangle())
            .overlay(alignment: .bottom) {
                if !isLast {
                    Rectangle()
                        .fill(Color(.separator))
                        .frame(height: 0.5)
                        .padding(.leading, 64)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let word = LibraryWord(
        rank: 4, word: "of", pos: "preposition", ipa: "/ɒv/",
        definition: "Expressing the relationship between a part and a whole.",
        altDefinition: nil, translation: "dari / milik", translationDef: nil,
        example1: "A cup of tea.", example2: nil, translationExample: nil,
        stage: .young
    )
    VStack(spacing: 0) {
        WordRow(word: word, isLast: false, onTap: {})
        WordRow(word: word, isLast: true,  onTap: {})
    }
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .padding()
    .background(Color(.systemGroupedBackground))
}
