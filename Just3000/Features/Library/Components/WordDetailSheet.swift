import SwiftUI

struct WordDetailSheet: View {
    let word: LibraryWord
    @Environment(\.dismiss) private var dismiss
    @State private var isMastered: Bool

    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

    init(word: LibraryWord) {
        self.word = word
        self._isMastered = State(initialValue: word.stage == .mastered)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // Header
                detailHeader

                // Definition card
                DetailCard {
                    VStack(alignment: .leading, spacing: 0) {
                        SectionLabel(text: "Definition", color: word.stage.color)
                        Text(word.definition)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.primary)
                            .lineSpacing(3)
                        if let alt = word.altDefinition {
                            Divider().padding(.vertical, 10)
                            Text(alt)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                // Indonesian translation card
                if let tr = word.translation {
                    translationCard(tr)
                }

                // Examples card
                DetailCard {
                    VStack(alignment: .leading, spacing: 0) {
                        SectionLabel(text: "Examples", color: word.stage.color)
                            .padding(.bottom, 10)
                        if let ex1 = Optional(word.example1) {
                            ExampleRow(text: ex1, accentColor: accent)
                        }
                        if let ex2 = word.example2 {
                            ExampleRow(text: ex2, accentColor: accent)
                                .padding(.top, 10)
                        }
                        if let idEx = word.translationExample {
                            Divider().padding(.vertical, 10)
                            ExampleRow(text: "🇮🇩 \(idEx)", accentColor: Color(red: 225/255, green: 29/255, blue: 72/255))
                        }
                    }
                }

                // SRS info card
                srsCard

                // Mastery toggle card
                masteryToggleCard
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGroupedBackground))
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium, .large])
    }

    // MARK: - Header
    private var detailHeader: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                StageBadge(stage: word.stage)

                HStack(spacing: 10) {
                    Text(word.word)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.primary)
                    Button { } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(accent)
                    }
                }
                .padding(.top, 10)

                HStack(spacing: 10) {
                    Text(word.pos)
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                        .italic()
                    Text(word.ipa)
                        .font(.system(size: 14, design: .monospaced))
                        .foregroundStyle(.secondary)
                    Text("#\(word.rank)")
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(Color(.tertiaryLabel))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 1)
                        .background(Color(.systemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.top, 3)
            }

            Spacer()

            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.secondary)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemFill))
                    .clipShape(Circle())
            }
        }
        .padding(.top, 4)
    }

    // MARK: - Indonesian card
    private func translationCard(_ tr: String) -> some View {
        let rose = Color(red: 225/255, green: 29/255, blue: 72/255)
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Text("🇮🇩")
                Text("Terjemahan Indonesia")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(rose)
                    .textCase(.uppercase)
                    .tracking(0.5)
            }
            .padding(.bottom, 5)

            Text(tr)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color(red: 159/255, green: 18/255, blue: 57/255))
                .padding(.bottom, 3)

            if let trDef = word.translationDef {
                Text(trDef)
                    .font(.system(size: 13))
                    .foregroundStyle(Color(red: 190/255, green: 24/255, blue: 93/255))
                    .lineSpacing(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(rose.opacity(0.07))
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(rose)
                .frame(width: 3)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - SRS card
    private var srsCard: some View {
        VStack(spacing: 0) {
            ForEach(srsRows.indices, id: \.self) { i in
                let row = srsRows[i]
                HStack {
                    Text(row.0)
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(row.1)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                if i < srsRows.count - 1 {
                    Divider().padding(.leading, 16)
                }
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
    }

    private var srsRows: [(String, String)] {
        [
            ("Next review",  isMastered ? "Paused" : "in 3 days"),
            ("Times seen",   "7 · 6 correct"),
            ("Ease factor",  "2.50"),
        ]
    }

    // MARK: - Mastery toggle card
    private var masteryToggleCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text("Mark as mastered")
                    .font(.system(size: 17))
                    .foregroundStyle(.primary)
                Text("Remove from review queue")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Toggle("", isOn: $isMastered)
                .labelsHidden()
                .tint(Color(red: 52/255, green: 199/255, blue: 89/255))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
    }
}

// MARK: - DetailCard
private struct DetailCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
    }
}

// MARK: - SectionLabel
private struct SectionLabel: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(color)
            .tracking(0.5)
            .padding(.bottom, 6)
    }
}

// MARK: - ExampleRow
private struct ExampleRow: View {
    let text: String
    let accentColor: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            RoundedRectangle(cornerRadius: 2)
                .fill(accentColor)
                .frame(width: 3)
                .padding(.top, 3)
            Text(text)
                .font(.system(size: 15))
                .foregroundStyle(.primary)
                .italic()
                .lineSpacing(2)
        }
    }
}

#Preview {
    let word = LibraryWord(
        rank: 4, word: "of", pos: "preposition", ipa: "/ɒv/",
        definition: "Expressing the relationship between a part and a whole.",
        altDefinition: "Used to indicate origin or belonging.",
        translation: "dari / milik",
        translationDef: "Menyatakan hubungan kepemilikan atau bagian dari sesuatu.",
        example1: "A cup of tea.",
        example2: "The color of the sky is blue.",
        translationExample: "Secangkir teh.",
        stage: .young
    )
    WordDetailSheet(word: word)
}
