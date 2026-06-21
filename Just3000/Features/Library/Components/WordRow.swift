import SwiftUI

struct WordRow: View {
    let word: LibraryWord
    let isLast: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text(String(format: "#%02d", word.rank))
                    .font(AppTypography.SFMono.caption1)
                    .foregroundStyle(Color(.tertiaryLabel))
                    .frame(minWidth: 24, alignment: .leading)

                VStack(alignment: .leading, spacing: 2) {
                    Text(word.word)
                        .font(AppTypography.Outfit.headline)
                        .foregroundStyle(.primary)
                    Text(word.pos)
                        .font(AppTypography.PlusJakartaSans.caption1)
                        .foregroundStyle(.secondary)
                        .italic()
                }

                Spacer()

                StageBadge(stage: word.stage)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
            .overlay(alignment: .bottom) {
                if !isLast {
                    Rectangle()
                        .fill(Color(.separator))
                        .frame(height: 0.5)
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
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding()
    .background(Color(.appBackground))
}
