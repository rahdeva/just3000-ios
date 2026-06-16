import SwiftUI

private let accent       = Color(red: 94/255,  green: 92/255,  blue: 230/255)
private let progressGreen = Color(red: 52/255, green: 199/255, blue: 89/255)

struct PracticeNavBar: View {
    let correct: Int
    let total: Int
    let progressFraction: Double
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button { onDismiss() } label: {
                ZStack {
                    Circle()
                        .fill(Color(.systemFill))
                        .frame(width: 32, height: 32)
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
            .buttonStyle(.plain)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemFill)).frame(height: 5)
                    Capsule()
                        .fill(progressGreen)
                        .frame(width: geo.size.width * progressFraction, height: 5)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: correct)
                }
            }
            .frame(height: 5)

            Text("EN → ID 🇮🇩")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(accent)
                .padding(.horizontal, 10).padding(.vertical, 3)
                .background(accent.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text("\(correct)/\(total)")
                .font(.system(size: 13, weight: .semibold).monospacedDigit())
                .foregroundStyle(.primary)
                .padding(.horizontal, 10).padding(.vertical, 3)
                .background(Color(.systemFill))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal, 16)
        .padding(.top, 60)
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    PracticeNavBar(correct: 3, total: 10, progressFraction: 0.3) {}
        .background(Color(.systemGroupedBackground))
}
