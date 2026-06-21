import SwiftUI

private let gradeGreen = Color(red: 52/255,  green: 199/255, blue: 89/255)
private let gradeRed   = Color(red: 255/255, green: 59/255,  blue: 48/255)

struct PracticeGradeButtons: View {
    let onDidntKnow: () -> Void
    let onKnewIt: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button { onDidntKnow() } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Circle().fill(gradeRed).frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Text("Didn't know")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(gradeRed)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(gradeRed.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)

            Button { onKnewIt() } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Circle().fill(.white.opacity(0.3)).frame(width: 36, height: 36)
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Text("I know it!")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(gradeGreen)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PracticeGradeButtons(onDidntKnow: {}, onKnewIt: {})
        .padding(.horizontal, 20).padding(.vertical, 20)
        .background(Color(.systemGroupedBackground))
}
