import SwiftUI

struct OnboardingDots: View {
    let n: Int
    let current: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<n, id: \.self) { i in
                Capsule()
                    .fill(i == current ? Color(.brandPrimary) : Color(.lightGray))
                    .frame(width: i == current ? 20 : 7, height: 7)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: current)
            }
        }
    }
}
