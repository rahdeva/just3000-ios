import SwiftUI

private let gradeGreen = Color(red: 52/255,  green: 199/255, blue: 89/255)
private let gradeRed   = Color(red: 255/255, green: 59/255,  blue: 48/255)

struct PracticeGradeButtons: View {
    let onDidntKnow: () -> Void
    let onKnewIt: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button { onDidntKnow() } label: {
                VStack(spacing: 8) {
                    playfulCircle(color: gradeRed, icon: "xmark")
                    Text("Don't know")
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)
                .playfulCard(
                    backgroundColor: gradeRed.opacity(0.10),
                    borderColor: gradeRed,
                    shadowColor: gradeRed.opacity(0.3),
                    cornerRadius: 16,
                    borderWidth: 2,
                    shadowOffset: CGSize(width: 3, height: 3),
                    horizontalPadding: 0,
                    verticalPadding: 14
                )
            }
            .buttonStyle(.plain)

            Button { onKnewIt() } label: {
                VStack(spacing: 8) {
                    playfulCircle(color: gradeGreen, icon: "checkmark")
                    Text("I know it!")
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)
                .playfulCard(
                    backgroundColor: gradeGreen.opacity(0.10),
                    borderColor: gradeGreen,
                    shadowColor: gradeGreen.opacity(0.3),
                    cornerRadius: 16,
                    borderWidth: 2,
                    shadowOffset: CGSize(width: 3, height: 3),
                    horizontalPadding: 0,
                    verticalPadding: 14
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func playfulCircle(color: Color, icon: String) -> some View {
        ZStack {
            Circle().fill(Color.primary).offset(x: 2, y: 2)
            Circle()
                .fill(color)
                .overlay { Circle().strokeBorder(Color.primary, lineWidth: 1.5) }
            Image(systemName: icon)
                .font(AppTypography.PlusJakartaSans.callout)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    PracticeGradeButtons(onDidntKnow: {}, onKnewIt: {})
        .padding(.horizontal, 20).padding(.vertical, 20)
        .background(Color(.appBackground))
}
