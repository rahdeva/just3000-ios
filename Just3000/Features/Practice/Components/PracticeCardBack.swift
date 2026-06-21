import SwiftUI

private let roseColor = Color(red: 225/255, green: 29/255, blue: 72/255)
private let roseDark  = Color(red: 159/255, green: 18/255, blue: 57/255)

struct PracticeCardBack: View {
    let card: PracticeCard
    let isFlipped: Bool
    let height: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                Text(card.word)
                    .font(AppTypography.Outfit.title2)
                    .foregroundStyle(.primary)
                Text(card.pos)
                    .font(AppTypography.PlusJakartaSans.callout)
                    .foregroundStyle(.secondary)
                    .italic()
                    .padding(.leading, 6)
                Spacer()
                Image(systemName: "speaker.wave.2.fill")
                    .font(AppTypography.PlusJakartaSans.body)
                    .foregroundStyle(Color(.brandPrimary))
            }
            .padding(.horizontal, 22).padding(.top, 22).padding(.bottom, 12)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🇬🇧 DEFINITION")
                            .font(AppTypography.PlusJakartaSans.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.brandPrimary))
                            .tracking(0.6)
                        Text(card.definition)
                            .font(AppTypography.PlusJakartaSans.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("🇮🇩 TERJEMAHAN")
                            .font(AppTypography.PlusJakartaSans.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(roseColor)
                            .tracking(0.6)
                        Text(card.translation)
                            .font(AppTypography.Outfit.title3)
                            .foregroundStyle(roseDark)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(roseColor.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    HStack(alignment: .top, spacing: 0) {
                        Rectangle().fill(Color(.brandPrimary)).frame(width: 3)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("EXAMPLE")
                                .font(AppTypography.PlusJakartaSans.caption2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.tertiaryLabel))
                                .tracking(0.5)
                            Text("\u{201C}\(card.example)\u{201D}")
                                .font(AppTypography.PlusJakartaSans.callout)
                                .foregroundStyle(.secondary)
                                .italic()
                                .lineSpacing(3)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 22).padding(.bottom, 8)
            }

            Text("Swipe or tap a button below")
                .font(AppTypography.PlusJakartaSans.caption1)
                .foregroundStyle(Color(.tertiaryLabel))
                .tracking(0.3)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .padding(.bottom, 8)
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
        .scaleEffect(x: isFlipped ? 1 : 0, y: 1)
        .opacity(isFlipped ? 1 : 0)
        .animation(isFlipped
            ? .easeOut(duration: 0.15).delay(0.15)
            : .easeIn(duration: 0.15),
            value: isFlipped)
    }
}

#Preview {
    let card = PracticeCard(rank: 1, word: "the", ipa: "/ðə/", pos: "article",
        definition: "Used to refer to a specific person or thing previously mentioned or known.",
        translation: "yang / itu", example: "The sun rises in the east.", stage: .mastered)
    PracticeCardBack(card: card, isFlipped: true, height: 400)
        .padding(20)
        .background(Color(.appBackground))
}
