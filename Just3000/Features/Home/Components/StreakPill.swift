import SwiftUI

struct StreakPill: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "flame.fill")
                .font(.system(size: 12, weight: .bold))
            Text("\(streak)")
                .font(AppTypography.Outfit.subheadline)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background {
            ZStack {
                Capsule()
                    .fill(Color.black)
                    .offset(x: 3, y: 3)
                Capsule()
                    .fill(Color.orange)
                    .overlay(
                        Capsule().strokeBorder(.black, lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    StreakPill(streak: 7)
        .padding()
        .background(Color(.systemGroupedBackground))
}
