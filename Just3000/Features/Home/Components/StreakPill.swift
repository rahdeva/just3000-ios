import SwiftUI

struct StreakPill: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "flame.fill")
                .font(.system(size: 12, weight: .bold))
            Text("\(streak)")
                .font(.system(size: 15, weight: .bold))
        }
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.orange)
        .clipShape(Capsule())
        .shadowPrimary()
    }
}

#Preview {
    StreakPill(streak: 7)
        .padding()
}
