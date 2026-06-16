import SwiftUI

struct ReviewNudgeRow: View {
    let dueCount: Int

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 7.5)
                    .fill(Color.orange)
                    .frame(width: 30, height: 30)
                Image(systemName: "clock.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
            }
            VStack(alignment: .leading, spacing: 1) {
                Text("\(dueCount) words due for review")
                    .font(.system(size: 17))
                    .foregroundStyle(.primary)
                Text("Spaced repetition scheduled")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color(.tertiaryLabel))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 11)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ReviewNudgeRow(dueCount: 24)
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
