import SwiftUI
import SwiftData

struct WordDetailSheet: View {
    let word: LibraryWord
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isMastered: Bool

    init(word: LibraryWord) {
        self.word = word
        self._isMastered = State(initialValue: word.stage == .mastered)
    }

    private var currentStage: WordStage {
        isMastered ? .mastered : (word.progress?.stage ?? .new)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                detailHeader

                if let definition = word.definition {
                    DetailCard {
                        VStack(alignment: .leading, spacing: 0) {
                            SectionLabel(text: "Definition", color: .black)
                            Text(definition)
                                .font(AppTypography.PlusJakartaSans.body)
                                .foregroundStyle(.primary)
                                .lineSpacing(3)
                            if let alt = word.altDefinition {
                                Divider().padding(.vertical, 10)
                                Text(alt)
                                    .font(AppTypography.PlusJakartaSans.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                if let tr = word.translation {
                    translationCard(tr)
                }

                if let ex1 = word.example1 {
                    DetailCard {
                        VStack(alignment: .leading, spacing: 0) {
                            SectionLabel(text: "Examples", color: .black)
                                .padding(.bottom, 10)
                            ExampleRow(text: ex1, accentColor: .brandPrimary)
                            if let ex2 = word.example2 {
                                ExampleRow(text: ex2, accentColor: .brandPrimary)
                                    .padding(.top, 10)
                            }
                            if let idEx = word.translationExample {
                                Divider().padding(.vertical, 10)
                                ExampleRow(
                                    text: "🇮🇩 \(idEx)",
                                    accentColor: Color(red: 225/255, green: 29/255, blue: 72/255)
                                )
                            }
                        }
                    }
                }

                srsCard

                if word.progress != nil {
                    masteryToggleCard
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .background(Color(.appBackground))
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium, .large])
        .onChange(of: isMastered) { _, newValue in
            guard let progress = word.progress else { return }
            progress.stage = newValue ? .mastered : .learning
            try? modelContext.save()
        }
    }

    // MARK: - Header

    private var detailHeader: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                StageBadge(stage: currentStage)

                HStack(spacing: 10) {
                    Text(word.word)
                        .font(AppTypography.Outfit.largeTitle)
                        .foregroundStyle(.primary)
                    Button { } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(.brandPrimary))
                    }
                }
                .padding(.top, 10)

                HStack(spacing: 10) {
                    if let pos = word.pos {
                        Text(pos)
                            .font(AppTypography.PlusJakartaSans.subheadline)
                            .foregroundStyle(.secondary)
                            .italic()
                    }
                    if let ipa = word.ipa {
                        Text(ipa)
                            .font(AppTypography.SFMono.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Text("#\(word.rank)")
                        .font(AppTypography.SFMono.caption2)
                        .foregroundStyle(Color(.tertiaryLabel))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color(.systemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.top, 4)
            }

            Spacer()

            CloseButton(style: .playful) { dismiss() }
        }
        .padding(.top, 24)
    }

    // MARK: - Translation card

    private func translationCard(_ tr: String) -> some View {
        let rose = Color(red: 225/255, green: 29/255, blue: 72/255)
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Text("🇮🇩")
                Text("Terjemahan Indonesia")
                    .font(AppTypography.PlusJakartaSans.caption1)
                    .fontWeight(.semibold)
                    .foregroundStyle(rose)
                    .textCase(.uppercase)
                    .tracking(0.5)
            }
            .padding(.bottom, 6)

            Text(tr)
                .font(AppTypography.Outfit.title3)
                .foregroundStyle(Color(red: 159/255, green: 18/255, blue: 57/255))
                .padding(.bottom, 3)

            if let trDef = word.translationDef {
                Text(trDef)
                    .font(AppTypography.PlusJakartaSans.footnote)
                    .foregroundStyle(Color(red: 190/255, green: 24/255, blue: 93/255))
                    .lineSpacing(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(rose.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .playfulCard(
            borderColor: .primary,
            cornerRadius: 16,
            borderWidth: 1.5,
            shadowOffset: CGSize(width: 4, height: 4),
            horizontalPadding: 0,
            verticalPadding: 0
        )
    }

    // MARK: - SRS card

    private var srsCard: some View {
        VStack(spacing: 0) {
            ForEach(srsRows.indices, id: \.self) { i in
                let row = srsRows[i]
                HStack {
                    Text(row.0)
                        .font(AppTypography.PlusJakartaSans.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(row.1)
                        .font(AppTypography.PlusJakartaSans.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                if i < srsRows.count - 1 {
                    Divider().padding(.leading, 16)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .playfulCard(
            backgroundColor: .white,
            borderColor: .primary,
            shadowColor: .primary,
            cornerRadius: 16,
            borderWidth: 1.5,
            shadowOffset: CGSize(width: 4, height: 4),
            horizontalPadding: 0,
            verticalPadding: 0
        )
    }

    private var srsRows: [(String, String)] {
        let p = word.progress

        let nextReview: String
        if isMastered {
            nextReview = "Paused"
        } else if let next = p?.nextReviewDate {
            nextReview = RelativeDateTimeFormatter().localizedString(for: next, relativeTo: Date())
        } else {
            nextReview = "Not started"
        }

        let seen    = p?.timesSeen ?? 0
        let correct = p?.correctCount ?? 0
        let ease    = p?.easeFactor ?? 2.5

        return [
            ("Next review", nextReview),
            ("Times seen",  seen > 0 ? "\(seen) · \(correct) correct" : "—"),
            ("Ease factor", String(format: "%.2f", ease)),
        ]
    }

    // MARK: - Mastery toggle card

    private var masteryToggleCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Mark as mastered")
                    .font(AppTypography.PlusJakartaSans.body)
                    .foregroundStyle(.primary)
                Text("Remove from review queue")
                    .font(AppTypography.PlusJakartaSans.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            ToggleButton(
                isOn: $isMastered,
                style: .playful,
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .playfulCard(
            backgroundColor: .white,
            borderColor: .primary,
            shadowColor: .primary,
            cornerRadius: 16,
            borderWidth: 1.5,
            shadowOffset: CGSize(width: 4, height: 4),
            horizontalPadding: 0,
            verticalPadding: 0
        )
    }
}

// MARK: - DetailCard

private struct DetailCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .playfulCard(
                backgroundColor: .white,
                borderColor: .primary,
                shadowColor: .primary,
                cornerRadius: 16,
                borderWidth: 1.5,
                shadowOffset: CGSize(width: 4, height: 4),
                horizontalPadding: 0,
                verticalPadding: 0
            )
    }
}

// MARK: - SectionLabel

private struct SectionLabel: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text.uppercased())
            .font(AppTypography.PlusJakartaSans.caption1)
            .fontWeight(.bold)
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
                .font(AppTypography.PlusJakartaSans.subheadline)
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
        progress: nil
    )
    WordDetailSheet(word: word)
}
