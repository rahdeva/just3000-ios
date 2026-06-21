import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct OnboardingFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(darkNavy)
                    .offset(x: 2, y: 2)
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(Color(.brandPrimary))
                    .overlay {
                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .strokeBorder(darkNavy, lineWidth: 1.5)
                    }
                Image(systemName: icon)
                    .font(AppTypography.PlusJakartaSans.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
            }
            .frame(width: 36, height: 36)
            Text(text)
                .font(AppTypography.PlusJakartaSans.callout)
                .foregroundStyle(darkNavy)
                .lineLimit(2)
            Spacer()
        }
        .padding(.horizontal, 14).padding(.vertical, 13)
        .playfulCard(
            borderColor: darkNavy,
            shadowColor: darkNavy.opacity(0.25),
            cornerRadius: 12,
            borderWidth: 2,
            horizontalPadding: 0,
            verticalPadding: 0
        )
    }
}
