import SwiftUI

struct OnboardingFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 9).fill(Color(.brandPrimary)).frame(width: 36, height: 36)
                .overlay(Image(systemName: icon).font(.system(size: 16, weight: .medium)).foregroundStyle(.white))
            Text(text).font(.system(size: 15)).foregroundStyle(Color(.neutralDarkSlate)).lineLimit(2)
            Spacer()
        }
        .padding(.horizontal, 14).padding(.vertical, 13)
        .background(Color(.offWhite), in: RoundedRectangle(cornerRadius: 12))
        .shadowPrimary()
    }
}
