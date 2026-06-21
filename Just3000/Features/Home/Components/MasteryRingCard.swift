import SwiftUI

struct MasteryRingCard: View {
    let viewModel: HomeViewModel

    // MARK: - Computed Properties

    private var totalCount: Int {
        max(viewModel.total, 0)
    }

    private var masteredCount: Int {
        max(viewModel.masteredCount, 0)
    }

    private var masteryProgress: Double {
        guard totalCount > 0 else {
            return 0
        }

        return min(
            max(Double(masteredCount) / Double(totalCount), 0),
            1
        )
    }

    private var stages: [MasteryStage] {
        [
            MasteryStage(
                id: "mastered",
                title: "Mastered",
                count: stageCount(for: "mastered"),
                color: .success
            ),
            MasteryStage(
                id: "mature",
                title: "Mature",
                count: stageCount(for: "mature"),
                color: .brandPrimary
            ),
            MasteryStage(
                id: "young",
                title: "Young",
                count: stageCount(for: "young"),
                color: .info
            ),
            MasteryStage(
                id: "learning",
                title: "Learning",
                count: stageCount(for: "learning"),
                color: .brandTertiary
            )
        ]
    }

    // MARK: - Body

    var body: some View {
        cardContent
            .playfulCard(
                backgroundColor: .white,
                borderColor: .primary,
                shadowColor: .primary,
                cornerRadius: 20,
                borderWidth: 2,
                horizontalPadding: 20,
                verticalPadding: 20
            )
            .padding(.horizontal, 16)
    }
}

// MARK: - Card Content

private extension MasteryRingCard {

    var cardContent: some View {
        HStack(
            alignment: .center,
            spacing: 22
        ) {
            masteryRing

            progressDetails
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
    }

    var masteryRing: some View {
        MasteryRing(
            progress: masteryProgress,
            masteredCount: masteredCount,
            totalCount: totalCount
        )
        .frame(
            width: 112,
            height: 112
        )
    }

    var progressDetails: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            Text("Vocabulary Progress")
                .font(AppTypography.Outfit.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.85)

            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(stages) { stage in
                    stageRow(stage)
                }
            }
        }
    }

    func stageRow(_ stage: MasteryStage) -> some View {
        HStack(spacing: 9) {
            stageIndicator(stage)

            Text(stage.title)
                .font(AppTypography.PlusJakartaSans.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(1)

            Spacer(minLength: 10)

            Text(stage.count.formatted())
                .font(AppTypography.SFMono.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .monospacedDigit()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(stage.title)
        .accessibilityValue("\(stage.count) words")
    }

    func stageIndicator(_ stage: MasteryStage) -> some View {
        RoundedRectangle(
            cornerRadius: 3,
            style: .continuous
        )
        .fill(stage.color)
        .frame(
            width: 12,
            height: 12
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: 3,
                style: .continuous
            )
            .stroke(
                Color.primary,
                lineWidth: 1.5
            )
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Helpers

private extension MasteryRingCard {

    func stageCount(for key: String) -> Int {
        max(
            viewModel.stageCounts[key] ?? 0,
            0
        )
    }
}

// MARK: - Stage Model

private struct MasteryStage: Identifiable {
    let id: String
    let title: String
    let count: Int
    let color: Color
}

// MARK: - Mastery Ring

private struct MasteryRing: View {
    let progress: Double
    let masteredCount: Int
    let totalCount: Int

    @Environment(\.accessibilityReduceMotion)
    private var accessibilityReduceMotion

    @State private var animatedProgress: Double = 0

    // MARK: - Values

    private let strokeWidth: CGFloat = 16

    private var clampedProgress: Double {
        min(
            max(progress, 0),
            1
        )
    }

    private var displayedPercentage: Int {
        Int(
            (animatedProgress * 100).rounded()
        )
    }

    private var countText: String {
        "\(masteredCount.formatted()) / \(totalCount.formatted())"
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            trackCircle
            progressCircle
            ringContent
        }
        .onAppear {
            updateProgress()
        }
        .onChange(of: clampedProgress) { _, _ in
            updateProgress()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Vocabulary mastery")
        .accessibilityValue(
            "\(displayedPercentage) percent, " +
            "\(masteredCount.formatted()) of " +
            "\(totalCount.formatted()) words mastered"
        )
    }
}

// MARK: - Ring Content

private extension MasteryRing {

    var trackCircle: some View {
        Circle()
            .stroke(
                Color.primary.opacity(0.06),
                style: StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: .round
                )
            )
    }

    var progressCircle: some View {
        Circle()
            .trim(
                from: 0,
                to: animatedProgress
            )
            .stroke(
                Color.brandPrimary,
                style: StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
    }

    var ringContent: some View {
        VStack(spacing: 2) {
            Text("\(displayedPercentage)%")
                .font(AppTypography.Outfit.title2)
                .foregroundStyle(.primary)
                .monospacedDigit()

            Text("mastered")
                .font(AppTypography.PlusJakartaSans.caption2)
                .foregroundStyle(.secondary)

            Text(countText)
                .font(AppTypography.SFMono.caption2)
                .foregroundStyle(.secondary)
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}

// MARK: - Animation

private extension MasteryRing {

    func updateProgress() {
        guard !accessibilityReduceMotion else {
            animatedProgress = clampedProgress
            return
        }

        withAnimation(
            .easeOut(duration: 0.9)
        ) {
            animatedProgress = clampedProgress
        }
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        MasteryRingCard(
            viewModel: HomeViewModel()
        )
        .padding(.vertical, 24)
    }
    .background(
        Color(.systemGroupedBackground)
    )
}
