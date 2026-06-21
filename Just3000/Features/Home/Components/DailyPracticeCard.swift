import SwiftUI

struct DailyPracticeCard: View {
    let viewModel: HomeViewModel

    @Binding var path: NavigationPath

    // MARK: - Computed Properties

    private var completedCount: Int {
        max(viewModel.doneToday, 0)
    }

    private var goalCount: Int {
        max(viewModel.goal, 0)
    }

    private var displayedCompletedCount: Int {
        min(completedCount, goalCount)
    }

    private var progress: Double {
        guard goalCount > 0 else {
            return 0
        }

        return min(
            Double(completedCount) / Double(goalCount),
            1
        )
    }

    private var isCompleted: Bool {
        viewModel.questDone ||
        (goalCount > 0 && completedCount >= goalCount)
    }

    private var cardColor: Color {
        isCompleted
            ? .success
            : .brandPrimary
    }

    private var title: String {
        isCompleted
            ? "Daily Goal Reached"
            : "Daily Practice"
    }

    private var progressText: String {
        "\(displayedCompletedCount)/\(goalCount)"
    }

    private var badgeIcon: String {
        isCompleted
            ? "checkmark"
            : "sparkle"
    }

    private var buttonIcon: String {
        isCompleted
            ? "checkmark"
            : "bolt.fill"
    }

    private var buttonTitle: String {
        if isCompleted {
            return "Continue Practicing"
        }

        if completedCount > 0 {
            return "Continue"
        }

        return "Start Practice"
    }

    // MARK: - Body

    var body: some View {
        cardContent
            .padding(.top, 16)
            .playfulCard(
                backgroundColor: cardColor,
                borderColor: .black,
                shadowColor: .black,
                cornerRadius: 20,
                borderWidth: 2,
                horizontalPadding: 20,
                verticalPadding: 20
            )
            .overlay(alignment: .topLeading) {
                floatingBadge
                    .offset(
                        x: 32,
                        y: -22
                    )
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
    }
}

// MARK: - Card Content

private extension DailyPracticeCard {

    var cardContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            progressBar

            actionButton
        }
    }

    var header: some View {
        HStack(
            alignment: .firstTextBaseline,
            spacing: 16
        ) {
            Text(title)
                .font(AppTypography.Outfit.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Spacer(minLength: 8)

            Text(progressText)
                .font(AppTypography.SFMono.callout)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    .white.opacity(0.16),
                    in: Capsule()
                )
                .overlay {
                    Capsule()
                        .stroke(
                            .white.opacity(0.35),
                            lineWidth: 2
                        )
                }
        }
    }

    var progressBar: some View {
        ProgressView(value: progress)
            .progressViewStyle(
                PlayfulProgressStyle(
                    trackColor: .black.opacity(0.18),
                    progressColor: .white.opacity(0.95),
                    height: 12
                )
            )
            .accessibilityLabel("Daily practice progress")
            .accessibilityValue(
                "\(displayedCompletedCount) of \(goalCount) words completed"
            )
    }

    var actionButton: some View {
        Button {
            path.append(AppRoute.practice)
        } label: {
            Label(
                buttonTitle,
                systemImage: buttonIcon
            )
            .font(AppTypography.PlusJakartaSans.callout)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(
            PlayfulButtonStyle(
                backgroundColor: .white,
                foregroundColor: cardColor,
                borderColor: .clear,
                shadowColor: .black.opacity(0.2),
                cornerRadius: 24,
                borderWidth: 0,
                shadowHeight: 5
            )
        )
    }
}

// MARK: - Floating Badge

private extension DailyPracticeCard {

    var floatingBadge: some View {
        Image(systemName: badgeIcon)
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(cardColor)
            .frame(width: 48, height: 48)
            .playfulCard(
                backgroundColor: .white,
                borderColor: .black,
                shadowColor: .black,
                cornerRadius: 14,
                borderWidth: 2,
                shadowOffset: CGSize(width: 4, height: 4),
                horizontalPadding: 0,
                verticalPadding: 0
            )
            .accessibilityHidden(true)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var path = NavigationPath()

    ScrollView {
        DailyPracticeCard(
            viewModel: HomeViewModel(),
            path: $path
        )
        .padding(.vertical, 24)
    }
    .background(Color(.systemGroupedBackground))
}
