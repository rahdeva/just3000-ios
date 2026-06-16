import SwiftUI

struct GoalStep: View {
    let onNext: (Int) -> Void
    @State private var selected: Int = 10
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(alignment: .leading, spacing: 22) {
                    Spacer().frame(height: 8)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Daily goal")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color(.neutralDarkSlate))
                        Text("Consistency beats grinding. You can always change this.")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.neutralSlate))
                    }
                    VStack(spacing: 10) {
                        ChoiceRow(title: "5 words",  subtitle: "~3 min · gentle habit",  selected: selected == 5)  { selected = 5 }
                        ChoiceRow(title: "10 words", subtitle: "~6 min · recommended",   selected: selected == 10) { selected = 10 }
                        ChoiceRow(title: "20 words", subtitle: "~12 min · fast track",   selected: selected == 20) { selected = 20 }
                    }
                    Spacer()
                }
            },
            footer: {
                VStack(spacing: 12) {
                    OnboardingDots(n: 4, current: 1)
                    OnboardingPrimaryButton("Continue") { onNext(selected) }
                }
            }
        )
    }
}
