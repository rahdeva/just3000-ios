import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct NotifStep: View {
    let onNext: () -> Void
    @State private var showPermAlert = false
    var body: some View {
        ZStack {
            OnboardingFrame(
                content: {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 32)
                        ZStack {
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(Color(.warning))
                                .offset(x: 3, y: 3)
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(.white)
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(Color(.warning).opacity(0.15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                                        .strokeBorder(Color(.warning), lineWidth: 2)
                                }
                            Image(systemName: "bell.fill")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundStyle(Color(.warning))
                        }
                        .frame(width: 88, height: 88)
                        .frame(maxWidth: .infinity)
                        VStack(spacing: 10) {
                            Text("Keep your streak! 🔥")
                                .font(AppTypography.Outfit.title2)
                                .foregroundStyle(darkNavy)
                                .multilineTextAlignment(.center)
                            Text("A daily nudge at **8:00 PM** if you haven't practised. Miss a day and your streak resets!")
                                .font(AppTypography.PlusJakartaSans.subheadline)
                                .foregroundStyle(darkNavy.opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                },
                footer: {
                    VStack(spacing: 10) {
                        OnboardingDots(n: 4, current: 2)
                        OnboardingPrimaryButton("Enable Reminders", icon: "bell.fill") { showPermAlert = true }
                        OnboardingPlainButton("Not now", action: onNext)
                    }
                }
            )
            if showPermAlert {
                Color.black.opacity(0.4).ignoresSafeArea()
                    .onTapGesture { showPermAlert = false }
                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Text("\"Just3000\" Would Like to Send You Notifications")
                            .font(AppTypography.PlusJakartaSans.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(darkNavy)
                            .multilineTextAlignment(.center)
                        Text("Alerts, sounds, and icon badges.")
                            .font(AppTypography.PlusJakartaSans.footnote)
                            .foregroundStyle(darkNavy.opacity(0.5))
                    }
                    .padding(20)
                    Divider()
                    HStack(spacing: 0) {
                        Button("Don't Allow") { showPermAlert = false; onNext() }
                            .frame(maxWidth: .infinity).foregroundStyle(Color(.info)).padding(.vertical, 13)
                        Divider().frame(height: 44)
                        Button("Allow") { showPermAlert = false; onNext() }
                            .frame(maxWidth: .infinity).fontWeight(.semibold).foregroundStyle(Color(.info)).padding(.vertical, 13)
                    }
                }
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal, 52)
                .transition(.scale(scale: 1.06).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showPermAlert)
    }
}
