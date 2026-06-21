import SwiftUI

struct NotifStep: View {
    let onNext: () -> Void
    @State private var showPermAlert = false
    var body: some View {
        ZStack {
            OnboardingFrame(
                content: {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 32)
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color(.warning).opacity(0.1))
                            .frame(width: 88, height: 88)
                            .overlay(Image(systemName: "bell.fill").font(.system(size: 40)).foregroundStyle(Color(.warning)))
                            .frame(maxWidth: .infinity)
                        VStack(spacing: 10) {
                            Text("Keep your streak!")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(Color(.neutralDarkSlate))
                            Text("A daily nudge at **8:00 PM** if you haven't practised. Miss a day and your streak resets!")
                                .font(.system(size: 15))
                                .foregroundStyle(Color(.neutralSlate))
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
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(.neutralDarkSlate))
                            .multilineTextAlignment(.center)
                        Text("Alerts, sounds, and icon badges.")
                            .font(.system(size: 13))
                            .foregroundStyle(Color(.neutralSlate))
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
