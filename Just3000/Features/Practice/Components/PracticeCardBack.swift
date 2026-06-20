import SwiftUI

private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)
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
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.primary)
                Text(card.pos)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .italic()
                    .padding(.leading, 6)
                Spacer()
                Image(systemName: "speaker.wave.2.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(accent)
            }
            .padding(.horizontal, 22).padding(.top, 22).padding(.bottom, 12)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🇬🇧 DEFINITION")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(accent)
                            .tracking(0.6)
                        Text(card.definition)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.primary)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("🇮🇩 TERJEMAHAN")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(roseColor)
                            .tracking(0.6)
                        Text(card.translation)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(roseDark)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(roseColor.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    HStack(alignment: .top, spacing: 0) {
                        Rectangle().fill(accent).frame(width: 3)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("EXAMPLE")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color(.tertiaryLabel))
                                .tracking(0.5)
                            Text("\u{201C}\(card.example)\u{201D}")
                                .font(.system(size: 14))
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
                .font(.system(size: 12))
                .foregroundStyle(Color(.tertiaryLabel))
                .tracking(0.3)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
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
        .background(Color(.systemGroupedBackground))
}
