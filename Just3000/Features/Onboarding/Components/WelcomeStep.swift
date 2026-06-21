import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct WelcomeStep: View {
    let onNext: () -> Void
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(spacing: 24) {
                    Spacer().frame(height: 16)
                    Image(AppImages.splashLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .frame(maxWidth: .infinity)
                    VStack(spacing: 10) {
                        Text("Learn the 3,000 words that cover **95% of English**")
                            .font(AppTypography.Outfit.title1)
                            .foregroundStyle(darkNavy)
                            .multilineTextAlignment(.center)
                        Text("One focused list. A daily habit. Science-backed spaced repetition.")
                            .font(AppTypography.PlusJakartaSans.subheadline)
                            .foregroundStyle(darkNavy.opacity(0.5))
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
                OnboardingPrimaryButton("Let's go!", icon: "arrow.right", action: onNext)
            }
        )
    }
}
