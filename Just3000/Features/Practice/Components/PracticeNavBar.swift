import SwiftUI

struct PracticeNavBar: View {
    let correct: Int
    let total: Int
    let progressFraction: Double
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            CloseButton(action: onDismiss)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemFill))
                    Capsule()
                        .fill(Color(.brandPrimary))
                        .frame(width: max(0, geo.size.width * progressFraction))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: correct)
                }
            }
            .frame(height: 14)

            Text("EN → ID 🇮🇩")
                .font(AppTypography.PlusJakartaSans.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .padding(.horizontal, 12).padding(.vertical, 7)
                .playfulCard(cornerRadius: 100, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)

            Text("\(correct)/\(total)")
                .font(AppTypography.SFMono.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .padding(.horizontal, 12).padding(.vertical, 7)
                .playfulCard(cornerRadius: 100, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
        }
        .padding(16)
    }
}

#Preview {
    PracticeNavBar(correct: 3, total: 10, progressFraction: 0.3) {}
        .background(Color(.appBackground))
}
