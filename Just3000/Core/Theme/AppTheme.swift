import SwiftUI

// MARK: - View Modifiers
extension View {
    func shadowPrimary() -> some View {
        self.shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Gradients
extension LinearGradient {
    static let primaryGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(.brandPrimary),
            Color(.brandPrimaryColor2)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let secondaryGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(.brandPrimary),
            Color(.brandPrimaryColor2)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let tertiaryGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(.brandTertiary),
            Color(.brandTertiaryColor2)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let quaternaryGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(.brandQuaternary),
            Color(.brandQuaternaryColor2)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
