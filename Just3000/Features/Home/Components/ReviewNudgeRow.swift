import SwiftUI

struct ReviewNudgeRow: View {
    let dueCount: Int
    @Binding var path: NavigationPath

    var body: some View {
        Button {
            path.append(AppRoute.practice)
        } label: {
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
            .shadowPrimary()
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    ReviewNudgeRow(dueCount: 24, path: $path)
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
