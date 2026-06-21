import SwiftUI

enum CloseButtonStyle {
    case native   // v1: rounded square + shadow
    case playful  // v2: rounded square + playfulCard
}

struct CloseButton: View {
    var style: CloseButtonStyle = .playful
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            switch style {
                case .native:
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.secondary)
                        .frame(width: 30, height: 30)
                        .background(Color(.systemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadowPrimary()

                case .playful:
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.secondary)
                        .frame(width: 30, height: 30)
                        .background(Color(.systemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .playfulCard(
                            cornerRadius: 10,
                            horizontalPadding: 0,
                            verticalPadding: 0
                        )
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 20) {
        CloseButton(style: .native) {}
        CloseButton(style: .playful) {}
    }
    .padding()
    .background(Color(.appBackground))
}
