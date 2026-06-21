import SwiftUI

struct SettingCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(AppTypography.PlusJakartaSans.caption1)
                .fontWeight(.semibold)
                .tracking(1.5)
                .foregroundStyle(Color(.secondaryLabel))
                .padding(.horizontal, 4)

            VStack(spacing: 0) {
                content
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .playfulCard(
                cornerRadius: 16,
                borderWidth: 2,
                horizontalPadding: 0,
                verticalPadding: 0
            )
        }
    }
}

struct SettingIconBadge: View {
    let name: String
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color)
                .frame(width: 30, height: 30)
            Image(systemName: name)
                .font(AppTypography.PlusJakartaSans.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SettingCard(title: "Preview") {
        SettingIconBadge(name: "info.circle.fill", color: .blue)
            .padding()
    }
    .padding()
    .background(Color(.appBackground))
}
