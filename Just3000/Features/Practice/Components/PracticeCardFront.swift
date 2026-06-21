import SwiftUI

struct PracticeCardFront: View {
    let card: PracticeCard
    let isFlipped: Bool
    let height: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("#\(card.rank)")
                    .font(AppTypography.SFMono.caption1)
                    .foregroundStyle(Color(.tertiaryLabel))
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(Color(.systemFill))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Spacer()
                HStack(spacing: 6) {
                    Text("🇬🇧 EN")
                        .font(AppTypography.PlusJakartaSans.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8).padding(.vertical, 3)
                        .playfulCard(
                            backgroundColor: Color(.brandPrimary),
                            borderColor: .primary,
                            shadowColor: .primary,
                            cornerRadius: 100,
                            borderWidth: 1.5,
                            shadowOffset: CGSize(width: 2, height: 2),
                            horizontalPadding: 0,
                            verticalPadding: 0
                        )
                    StageBadge(stage: card.stage)
                }
            }
            .padding(.horizontal, 22).padding(.top, 22)

            Spacer()

            VStack(spacing: 8) {
                Text(card.word)
                    .font(.custom("Outfit-Bold", size: 52))
                    .foregroundStyle(.primary)
                    .kerning(-2)
                    .multilineTextAlignment(.center)
                Text(card.ipa)
                    .font(AppTypography.SFMono.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 6) {
                Circle().fill(Color(.brandPrimary).opacity(0.3)).frame(width: 6, height: 6)
                Text("Tap to reveal")
                    .font(AppTypography.PlusJakartaSans.footnote)
                    .foregroundStyle(Color(.tertiaryLabel))
                Circle().fill(Color(.brandPrimary).opacity(0.3)).frame(width: 6, height: 6)
            }
            .padding(.bottom, 22)
        }
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .playfulCard(
            cornerRadius: 20,
            borderWidth: 2,
            shadowOffset: CGSize(width: 5, height: 5),
            horizontalPadding: 0,
            verticalPadding: 0
        )
        .scaleEffect(x: isFlipped ? 0 : 1, y: 1)
        .opacity(isFlipped ? 0 : 1)
        .animation(isFlipped
            ? .easeIn(duration: 0.15)
            : .easeOut(duration: 0.15).delay(0.15),
            value: isFlipped)
    }
}

#Preview {
    let card = PracticeCard(rank: 1, word: "the", ipa: "/ðə/", pos: "article",
        definition: "Used to refer to a specific person or thing.", translation: "yang / itu",
        example: "The sun rises in the east.", stage: .mastered)
    PracticeCardFront(card: card, isFlipped: false, height: 400)
        .padding(20)
        .background(Color(.appBackground))
}
