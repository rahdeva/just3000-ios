import SwiftUI

struct WelcomeStep: View {
    let onNext: () -> Void
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(spacing: 24) {
                    Spacer().frame(height: 16)
                    VStack(spacing: 12) {
                        Text("Learn the 3,000 words that cover **95% of English**")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color(.neutralDarkSlate))
                            .multilineTextAlignment(.center)
                        Text("One focused list. A daily habit. Science-backed spaced repetition.")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.neutralSlate))
                            .multilineTextAlignment(.center)
                    }
                    VStack(spacing: 10) {
                        OnboardingFeatureRow(icon: "target", text: "A single frequency-ranked list of 3,000")
                        OnboardingFeatureRow(icon: "bolt.fill", text: "A few minutes a day, scheduled by science")
                        OnboardingFeatureRow(icon: "chart.bar.fill", text: "Always know exactly how many you've mastered")
                    }
                    Spacer()
                }
            },
            footer: {
                OnboardingPrimaryButton("Get started", icon: "arrow.right", action: onNext)
            }
        )
    }
}
