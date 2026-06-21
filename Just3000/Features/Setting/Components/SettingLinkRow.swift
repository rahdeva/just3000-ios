import SwiftUI

struct SettingLinkRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            HStack(spacing: 12) {
                SettingIconBadge(name: icon, color: iconColor)
                Text(label)
                    .font(AppTypography.PlusJakartaSans.callout)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(AppTypography.PlusJakartaSans.caption1)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingLinkRow(icon: "hand.raised.fill", iconColor: .blue,              label: "Privacy Policy",    url: URL(string: "https://example.com")!)
        Divider().padding(.leading, 58)
        SettingLinkRow(icon: "doc.text.fill",    iconColor: Color(.brandPrimary), label: "Terms & Conditions", url: URL(string: "https://example.com")!)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .playfulCard(cornerRadius: 16, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
    .padding()
    .background(Color(.appBackground))
}
