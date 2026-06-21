import SwiftUI

struct OnboardingFrame<C: View, F: View>: View {
    @ViewBuilder let content: C
    @ViewBuilder let footer: F

    init(content: () -> C, footer: () -> F) {
        self.content = content()
        self.footer  = footer()
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView { content.padding(.horizontal, 20) }
            footer.padding(.horizontal, 20).padding(.bottom, 44).padding(.top, 12)
        }
    }
}
