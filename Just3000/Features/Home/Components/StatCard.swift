import SwiftUI

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)

            Text(value)
                .font(AppTypography.Outfit.title2)
                .foregroundStyle(.primary)
                .monospacedDigit()
                .padding(.top, 6)

            Text(label)
                .font(AppTypography.PlusJakartaSans.caption1)
                .foregroundStyle(.secondary)
                .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .playfulCard(
            cornerRadius: 20,
            borderWidth: 2,
            horizontalPadding: 16,
            verticalPadding: 16
        )
    }
}

#Preview {
    HStack(spacing: 12) {
        StatCard(
            value: "7",
            label: "Day streak",
            icon: "flame.fill",
            color: .orange
        )

        StatCard(
            value: "14",
            label: "Best streak",
            icon: "crown.fill",
            color: .brandPrimary
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
