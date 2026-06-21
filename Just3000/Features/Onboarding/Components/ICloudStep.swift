import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct ICloudStep: View {
    let onDone: () -> Void
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(spacing: 20) {
                    Spacer().frame(height: 32)
                    ZStack {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .fill(Color(.brandPrimary))
                            .offset(x: 3, y: 3)
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .fill(.white)
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .fill(Color(.brandPrimary).opacity(0.15))
                            .overlay {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .strokeBorder(Color(.brandPrimary), lineWidth: 2)
                            }
                        Image(systemName: "cloud.fill")
                            .font(.system(size: 36, weight: .medium))
                            .foregroundStyle(Color(.brandPrimary))
                    }
                    .frame(width: 88, height: 88)
                    .frame(maxWidth: .infinity)
                    VStack(spacing: 10) {
                        Text("Sync your progress 🌤")
                            .font(AppTypography.Outfit.title2)
                            .foregroundStyle(darkNavy)
                            .multilineTextAlignment(.center)
                        Text("Your streaks, progress, and mastered words sync privately through iCloud.")
                            .font(AppTypography.PlusJakartaSans.subheadline)
                            .foregroundStyle(darkNavy.opacity(0.5))
                            .multilineTextAlignment(.center)
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill")
                            .font(AppTypography.PlusJakartaSans.footnote)
                            .foregroundStyle(Color(.success))
                        Text("End-to-end encrypted · zero personal data")
                            .font(AppTypography.PlusJakartaSans.footnote)
                            .foregroundStyle(darkNavy.opacity(0.5))
                    }
                    .padding(.horizontal, 16).padding(.vertical, 12)
                    .playfulCard(
                        backgroundColor: Color(.success).opacity(0.1),
                        borderColor: Color(.success),
                        shadowColor: Color(.success).opacity(0.1),
                        cornerRadius: 12,
                        borderWidth: 1.5,
                        shadowOffset: CGSize(width: 2, height: 2),
                        horizontalPadding: 0,
                        verticalPadding: 0
                    )
                    Spacer()
                }
            },
            footer: {
                VStack(spacing: 10) {
                    OnboardingDots(n: 4, current: 3)
                    OnboardingPrimaryButton("Enable iCloud Sync", icon: "cloud.fill", action: onDone)
                    OnboardingPlainButton("Use offline only", action: onDone)
                }
            }
        )
    }
}
