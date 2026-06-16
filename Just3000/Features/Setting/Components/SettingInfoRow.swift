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
                .font(.system(size: 16))
                .foregroundStyle(.primary)
            Spacer()
            Text(value)
                .font(.system(size: 15))
                .foregroundStyle(Color(.secondaryLabel))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingInfoRow(icon: "info.circle.fill", iconColor: .blue,   label: "Version",       value: "1.0.0")
        Divider().padding(.leading, 52)
        SettingInfoRow(icon: "books.vertical.fill", iconColor: Color(red: 94/255, green: 92/255, blue: 230/255), label: "Words in list", value: "3,000")
    }
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .padding()
    .background(Color(.systemGroupedBackground))
}
