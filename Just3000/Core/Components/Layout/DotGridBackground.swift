import SwiftUI

struct DotGridBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()

            Image(AppImages.bgDotGrid)
                .resizable(resizingMode: .tile)
                .ignoresSafeArea()
                .opacity(0.45)

            content
        }
    }
}

extension View {
    func dotGridBackground() -> some View {
        modifier(DotGridBackground())
    }
}
