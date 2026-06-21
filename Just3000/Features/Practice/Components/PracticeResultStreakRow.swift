import SwiftUI

private let streakOrange = Color(red: 255/255, green: 149/255, blue: 0)

struct PracticeResultStreakRow: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "flame.fill")
                .font(AppTypography.PlusJakartaSans.callout)
                .foregroundStyle(streakOrange)
            Text("Streak is now \(streak) days 🔥")
                .font(AppTypography.PlusJakartaSans.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 16).padding(.vertical, 12)
        .playfulCard(
            backgroundColor: streakOrange.opacity(0.1),
            borderColor: streakOrange,
            shadowColor: streakOrange.opacity(0.3),
            cornerRadius: 14,
            borderWidth: 2,
            shadowOffset: CGSize(width: 3, height: 3),
            horizontalPadding: 0,
            verticalPadding: 0
        )
    }
}

#Preview {
    PracticeResultStreakRow(streak: 8)
        .padding()
        .background(Color(.appBackground))
}
