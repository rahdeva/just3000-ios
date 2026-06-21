import SwiftUI

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
                .font(AppTypography.PlusJakartaSans.callout)
                .foregroundStyle(.primary)
            Spacer()
            HStack(spacing: 0) {
                Button(action: onDecrement) {
                    Image(systemName: "minus")
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.brandPrimary))
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
                Text(value)
                    .font(AppTypography.SFMono.footnote)
                    .foregroundStyle(.primary)
                    .frame(minWidth: 64)
                Button(action: onIncrement) {
                    Image(systemName: "plus")
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.brandPrimary))
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
            }
            .background(Color(.systemFill))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(.primary.opacity(0.12), lineWidth: 1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
    }
}

#Preview {
    SettingStepperRow(
        icon: "flag.fill", iconColor: Color(.brandPrimary),
        label: "Daily goal", value: "20 words",
        onDecrement: {}, onIncrement: {}
    )
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .playfulCard(cornerRadius: 16, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
    .padding()
    .background(Color(.appBackground))
}
