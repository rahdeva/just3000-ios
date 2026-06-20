import SwiftUI

struct SettingCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color(.secondaryLabel))
                .padding(.horizontal, 4)

            VStack(spacing: 0) {
                content
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadowPrimary()
        }
    }
}

struct SettingIconBadge: View {
    let name: String
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(color)
                .frame(width: 28, height: 28)
            Image(systemName: name)
                .font(.system(size: 14, weight: .semibold))
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
    .background(Color(.systemGroupedBackground))
}
