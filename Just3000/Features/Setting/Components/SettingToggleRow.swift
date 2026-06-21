import SwiftUI

struct SettingToggleRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            SettingIconBadge(name: icon, color: iconColor)
            Text(label)
                .font(AppTypography.PlusJakartaSans.callout)
                .foregroundStyle(.primary)
            Spacer()
            ToggleButton(isOn: $isOn)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .animation(.easeInOut(duration: 0.2), value: isOn)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingToggleRow(icon: "bell.fill",   iconColor: .red,                  label: "Daily reminder", isOn: .constant(true))
        Divider()
        SettingToggleRow(icon: "icloud.fill", iconColor: Color(.brandPrimary),  label: "iCloud Sync",    isOn: .constant(false))
    }
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .playfulCard(cornerRadius: 16, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
    .padding()
    .background(Color(.appBackground))
}
