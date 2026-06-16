import SwiftUI

private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

struct SettingStepperRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String
    let onDecrement: () -> Void
    let onIncrement: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            SettingIconBadge(name: icon, color: iconColor)
            Text(label)
                .font(.system(size: 16))
                .foregroundStyle(.primary)
            Spacer()
            HStack(spacing: 0) {
                Button(action: onDecrement) {
                    Image(systemName: "minus")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(accent)
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
                Text(value)
                    .font(.system(size: 13, weight: .semibold).monospacedDigit())
                    .foregroundStyle(.primary)
                    .frame(minWidth: 64)
                Button(action: onIncrement) {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(accent)
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
            }
            .background(Color(.systemFill))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
    }
}

#Preview {
    SettingStepperRow(
        icon: "flag.fill", iconColor: accent,
        label: "Daily goal", value: "20 words",
        onDecrement: {}, onIncrement: {}
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
