import SwiftUI

private let rGreen  = Color(red: 52/255,  green: 199/255, blue: 89/255)
private let rOrange = Color(red: 255/255, green: 149/255, blue: 0)
private let rPurple = Color(red: 175/255, green: 82/255,  blue: 222/255)

struct PracticeResultView: View {
    @Binding var path: NavigationPath
    var correct:   Int = 8
    var incorrect: Int = 2
    var total:     Int = 10
    var mastered:  Int = 1
    var newSeen:   Int = 3
    var streak:    Int = 8

    @State private var iconScale: CGFloat = 0.4
    @State private var confettiActive = false

    private var accuracy: Int {
        (correct + incorrect) > 0 ? correct * 100 / (correct + incorrect) : 0
    }

    private var subtitle: String {
        accuracy >= 80
            ? "Excellent work, streak secured 🔥"
            : "Nice work, keep building that habit!"
    }

    private var stats: [(icon: String, label: String, value: String, color: Color)] {[
        ("scope",      "Accuracy",   "\(accuracy)%", Color(.brandPrimary)),
        ("flame.fill", "Day streak", "\(streak)",    rOrange),
        ("star.fill",  "Mastered",   "+\(mastered)", rGreen),
        ("sparkles",   "New words",  "\(newSeen)",   rPurple),
    ]}

    var body: some View {
        ZStack {
            Color(.appBackground).ignoresSafeArea()
            Image(AppImages.bgDotGrid).resizable(resizingMode: .tile).ignoresSafeArea().opacity(0.45)

            if confettiActive {
                ConfettiView(count: accuracy >= 80 ? 60 : 32)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            }

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(rGreen)
                            .frame(width: 90, height: 90)
                            .shadow(color: rGreen.opacity(0.35), radius: 16, x: 0, y: 6)
                        Image(systemName: "checkmark")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(iconScale)

                    Text("Session complete!")
                        .font(AppTypography.Outfit.title1)
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(AppTypography.PlusJakartaSans.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(stats, id: \.label) { stat in
                        PracticeResultStatCard(
                            icon: stat.icon, label: stat.label,
                            value: stat.value, color: stat.color
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 28)

                PracticeResultStreakRow(streak: streak)
                    .padding(.horizontal, 20)
                    .padding(.top, 14)

                Spacer()

                Button {
                    path.removeLast(path.count)
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "house.fill")
                        Text("Back to Home")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(
                    PlayfulButtonStyle(
                        backgroundColor: Color(.brandPrimary),
                        foregroundColor: .white,
                        borderColor: .primary,
                        shadowColor: .primary,
                        cornerRadius: 16,
                        borderWidth: 2,
                        shadowHeight: 4
                    )
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.1)) {
                iconScale = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                confettiActive = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        PracticeResultView(
            path: .constant(NavigationPath()),
            correct: 8,
            incorrect: 2,
            total: 10,
            mastered: 2,
            newSeen: 3,
            streak: 8
        )
    }
}
