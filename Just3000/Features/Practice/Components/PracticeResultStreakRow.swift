import SwiftUI

private let streakOrange = Color(red: 255/255, green: 149/255, blue: 0)

struct PracticeResultStreakRow: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "flame.fill")
                .font(.system(size: 16))
                .foregroundStyle(streakOrange)
            Text("Streak is now \(streak) days 🔥")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 16).padding(.vertical, 12)
        .background(streakOrange.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    PracticeResultStreakRow(streak: 8)
        .padding()
        .background(Color(.systemGroupedBackground))
}
