import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct LevelStep: View {
    let onNext: (StudyLevel) -> Void
    @State private var selected: StudyLevel = .intermediate
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(alignment: .leading, spacing: 22) {
                    Spacer().frame(height: 8)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("What's your level? 🎯")
                            .font(AppTypography.Outfit.title1)
                            .foregroundStyle(darkNavy)
                        Text("We'll start you at the right spot in the frequency list.")
                            .font(AppTypography.PlusJakartaSans.subheadline)
                            .foregroundStyle(darkNavy.opacity(0.5))
                    }
                    VStack(spacing: 10) {
                        ChoiceRow(badge: "1",    title: "Beginner",     subtitle: "Start at rank 1 · the essentials",      selected: selected == .beginner)     { selected = .beginner }
                        ChoiceRow(badge: "501",  title: "Intermediate", subtitle: "Start at rank 501 · skip the basics",   selected: selected == .intermediate) { selected = .intermediate }
                        ChoiceRow(badge: "1001", title: "Advanced",     subtitle: "Start at rank 1001 · the harder 2,000", selected: selected == .advanced)     { selected = .advanced }
                    }
                    Spacer()
                }
            },
            footer: {
                VStack(spacing: 12) {
                    OnboardingDots(n: 4, current: 0)
                    OnboardingPrimaryButton("Continue") { onNext(selected) }
                }
            }
        )
    }
}
