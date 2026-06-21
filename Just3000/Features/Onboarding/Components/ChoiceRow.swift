import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)
private let lightBadgeFill = Color(red: 240/255, green: 240/255, blue: 244/255)

struct ChoiceRow: View {
    var badge: String? = nil
    let title: String
    let subtitle: String
    let selected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                if let badge {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(darkNavy)
                            .offset(x: 1.5, y: 1.5)
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(selected ? Color(.brandPrimary) : lightBadgeFill)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(darkNavy, lineWidth: 1.5)
                            }
                        Text(badge)
                            .font(AppTypography.SFMono.caption1)
                            .fontWeight(.semibold)
                            .foregroundStyle(selected ? .white : darkNavy.opacity(0.5))
                    }
                    .frame(width: 42, height: 42)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AppTypography.PlusJakartaSans.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(darkNavy)
                    Text(subtitle)
                        .font(AppTypography.PlusJakartaSans.caption1)
                        .foregroundStyle(darkNavy.opacity(0.5))
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(selected ? Color(.brandPrimary) : .clear)
                        .overlay {
                            Circle().strokeBorder(
                                selected ? Color(.brandPrimary) : darkNavy.opacity(0.3),
                                lineWidth: 2
                            )
                        }
                        .frame(width: 22, height: 22)
                    if selected {
                        Image(systemName: "checkmark")
                            .font(AppTypography.PlusJakartaSans.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .playfulCard(
                backgroundColor: .white,
                borderColor: selected ? Color(.brandPrimary) : darkNavy,
                shadowColor: selected ? Color(.brandPrimary).opacity(0.3) : darkNavy.opacity(0.25),
                cornerRadius: 14,
                borderWidth: 2,
                shadowOffset: CGSize(width: 3, height: 3),
                horizontalPadding: 0,
                verticalPadding: 0
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: selected)
    }
}
