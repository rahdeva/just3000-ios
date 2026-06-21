import SwiftUI

struct ICloudStep: View {
    let onDone: () -> Void
    var body: some View {
        OnboardingFrame(
            content: {
                VStack(spacing: 20) {
                    Spacer().frame(height: 32)
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color(.brandPrimary).opacity(0.1))
                        .frame(width: 88, height: 88)
                        .overlay(Image(systemName: "cloud.fill").font(.system(size: 40)).foregroundStyle(Color(.brandPrimary)))
                        .frame(maxWidth: .infinity)
                    VStack(spacing: 10) {
                        Text("Sync your progress")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(Color(.neutralDarkSlate))
                        Text("Your streaks, progress, and mastered words sync privately through iCloud.")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.neutralSlate))
                            .multilineTextAlignment(.center)
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill").font(.system(size: 14)).foregroundStyle(Color(.success))
                        Text("End-to-end encrypted · zero personal data")
                            .font(.system(size: 13)).foregroundStyle(Color(.neutralSlate))
                    }
                    .padding(.horizontal, 16).padding(.vertical, 12)
                    .background(Color(.success).opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
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
