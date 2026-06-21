import SwiftUI

struct SettingInfoRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            SettingIconBadge(name: icon, color: iconColor)
            Text(label)
                .font(AppTypography.PlusJakartaSans.callout)
                .foregroundStyle(.primary)
            Spacer()
            Text(value)
                .font(AppTypography.PlusJakartaSans.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingInfoRow(icon: "info.circle.fill",    iconColor: .blue,             label: "Version",       value: "1.0.0")
        Divider()
        SettingInfoRow(icon: "books.vertical.fill", iconColor: Color(.brandPrimary), label: "Words in list", value: "3,000")
    }
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .playfulCard(cornerRadius: 16, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
    .padding()
    .background(Color(.appBackground))
}
