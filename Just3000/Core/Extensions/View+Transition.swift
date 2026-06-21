import SwiftUI

extension View {
    func slideTransition() -> some View {
        transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
}
