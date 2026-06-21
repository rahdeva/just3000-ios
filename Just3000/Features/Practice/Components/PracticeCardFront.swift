import SwiftUI

private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

struct PracticeCardFront: View {
    let card: PracticeCard
    let isFlipped: Bool
    let height: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("#\(card.rank)")
                    .font(.system(size: 12, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .padding(.horizontal, 8).padding(.vertical, 2)
                    .background(Color(.systemFill))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Spacer()
                HStack(spacing: 6) {
                    Text("🇬🇧 EN")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(accent)
                        .padding(.horizontal, 8).padding(.vertical, 2)
                        .background(accent.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    StageBadge(stage: card.stage)
                }
            }
            .padding(.horizontal, 22).padding(.top, 22)

            Spacer()

            VStack(spacing: 8) {
                Text(card.word)
                    .font(.system(size: 52, weight: .bold))
                    .foregroundStyle(.primary)
                    .kerning(-2)
                    .multilineTextAlignment(.center)
                Text(card.ipa)
                    .font(.system(size: 15, design: .monospaced))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 6) {
                Circle().fill(Color(.systemFill)).frame(width: 6, height: 6)
                Text("Tap to reveal")
                    .font(.system(size: 13))
                    .foregroundStyle(Color(.tertiaryLabel))
                Circle().fill(Color(.systemFill)).frame(width: 6, height: 6)
            }
            .padding(.bottom, 22)
        }
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
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
        .background(Color(.systemGroupedBackground))
}
