import SwiftUI

struct OnboardingPlainButton: View {
    let title: String
    let action: () -> Void

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title; self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title).font(.system(size: 17, weight: .medium))
                .foregroundStyle(Color(.brandPrimary))
                .frame(maxWidth: .infinity).padding(.vertical, 12)
        }
    }
}
