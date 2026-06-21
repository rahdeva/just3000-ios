import SwiftUI

struct ReviewNudgeRow: View {
    let dueCount: Int

    @Binding var path: NavigationPath

    // MARK: - Computed Properties

    private var displayedDueCount: Int {
        max(dueCount, 0)
    }

    private var wordLabel: String {
        displayedDueCount == 1 ? "word" : "words"
    }

    private var title: String {
        "\(displayedDueCount.formatted()) \(wordLabel) due for review"
    }

    private var subtitle: String {
        "Spaced-repetition scheduled"
    }

    private var badgeColor: Color {
        .brandTertiary
    }

    // MARK: - Body

    var body: some View {
        Button {
            openPractice()
        } label: {
            card
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityValue(subtitle)
        .accessibilityHint("Opens vocabulary review practice")
    }
}

// MARK: - Card

private extension ReviewNudgeRow {

    var card: some View {
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

    var cardContent: some View {
        HStack(
            alignment: .center,
            spacing: 16
        ) {
            badge

            textContent

            Spacer(minLength: 8)

            chevronIcon
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    var textContent: some View {
        VStack(
            alignment: .leading,
            spacing: 4
        ) {
            Text(title)
                .font(AppTypography.Outfit.callout)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.85)

            Text(subtitle)
                .font(AppTypography.PlusJakartaSans.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }

    var chevronIcon: some View {
        Image(systemName: "chevron.right")
            .font(
                .system(
                    size: 17,
                    weight: .bold
                )
            )
            .foregroundStyle(
                Color.secondary.opacity(0.65)
            )
            .accessibilityHidden(true)
    }
}

// MARK: - Badge

private extension ReviewNudgeRow {

    var badge: some View {
        Image(systemName: "clock")
            .font(
                .system(
                    size: 19,
                    weight: .bold
                )
            )
            .foregroundStyle(.white)
            .frame(
                width: 46,
                height: 46
            )
            .playfulCard(
                backgroundColor: badgeColor,
                borderColor: .primary,
                shadowColor: .primary,
                cornerRadius: 14,
                borderWidth: 2,
                shadowOffset: CGSize(
                    width: 3,
                    height: 4
                ),
                horizontalPadding: 0,
                verticalPadding: 0
            )
            .accessibilityHidden(true)
    }
}

// MARK: - Actions

private extension ReviewNudgeRow {

    func openPractice() {
        path.append(AppRoute.practice)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var path = NavigationPath()

    ScrollView {
        ReviewNudgeRow(
            dueCount: 23,
            path: $path
        )
        .padding(.vertical, 24)
    }
    .background(
        Color(.systemGroupedBackground)
    )
}
