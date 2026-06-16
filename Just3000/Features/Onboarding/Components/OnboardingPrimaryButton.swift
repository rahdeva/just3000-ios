import SwiftUI

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
                if let icon { Image(systemName: icon).font(.system(size: 16, weight: .semibold)) }
                Text(title).font(.system(size: 17, weight: .semibold))
            }
            .frame(maxWidth: .infinity).padding(.vertical, 15)
            .background(Color(.brandPrimary), in: RoundedRectangle(cornerRadius: 14))
            .foregroundStyle(.white)
        }
    }
}
