import SwiftUI

enum ToggleButtonStyle {
    case native   // v1: iOS default toggle
    case playful  // v2: custom track with border + shadow
}

struct ToggleButton: View {
    @Binding var isOn: Bool
    var style: ToggleButtonStyle = .playful
    var onTint: Color = Color(.brandPrimary)

    var body: some View {
        switch style {
            case .native:
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(onTint)
                    .shadowPrimary()

            case .playful:
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(onTint)
                    .playfulCard(
                        horizontalPadding: 0,
                        verticalPadding: 0
                    )
        }
    }
}

#Preview {
    @Previewable @State var isOn = true

    VStack(spacing: 20) {
        HStack(spacing: 20) {
            ToggleButton(isOn: $isOn, style: .native)
            ToggleButton(isOn: $isOn, style: .playful)
        }
        HStack(spacing: 20) {
            ToggleButton(isOn: .constant(false), style: .native)
            ToggleButton(isOn: .constant(false), style: .playful)
        }
    }
    .padding()
    .background(Color(.appBackground))
}
