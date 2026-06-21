import SwiftUI

private let darkNavy = Color(red: 28/255, green: 28/255, blue: 36/255)

struct OnboardingPrimaryButton: View {
    let title: String
    var icon: String? = nil
    let action: () -> Void

    init(_ title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title; self.icon = icon; self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon { Image(systemName: icon) }
                Text(title)
            }
        }
        .buttonStyle(
            PlayfulButtonStyle(
                backgroundColor: Color(.brandPrimary),
                foregroundColor: .white,
                borderColor: darkNavy,
                shadowColor: darkNavy,
                cornerRadius: 16,
                borderWidth: 2,
                shadowHeight: 4
            )
        )
    }
}
