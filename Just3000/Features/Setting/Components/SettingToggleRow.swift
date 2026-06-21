import SwiftUI

private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

struct SettingToggleRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            SettingIconBadge(name: icon, color: iconColor)
            Text(label)
                .font(.system(size: 16))
                .foregroundStyle(.primary)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(accent)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .animation(.easeInOut(duration: 0.2), value: isOn)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingToggleRow(icon: "bell.fill",   iconColor: .red,   label: "Daily reminder", isOn: .constant(true))
        Divider().padding(.leading, 52)
        SettingToggleRow(icon: "icloud.fill", iconColor: accent, label: "iCloud Sync",    isOn: .constant(false))
    }
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .padding()
    .background(Color(.systemGroupedBackground))
}
