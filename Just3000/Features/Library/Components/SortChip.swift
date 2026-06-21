import SwiftUI

struct SortChip: View {
    let label: String
    let isOn: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(AppTypography.PlusJakartaSans.footnote)
                .fontWeight(.bold)
                .foregroundStyle(isOn ? Color(.systemBackground) : Color(.label))
                .playfulCard(
                    backgroundColor: isOn ? Color(.label) : Color(.systemBackground),
                    borderColor: .primary,
                    shadowColor: .primary,
                    cornerRadius: 20,
                    borderWidth: 1.5,
                    shadowOffset: CGSize(width: 2, height: 2),
                    horizontalPadding: 16,
                    verticalPadding: 8
                )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isOn)
    }
}

#Preview {
    HStack(spacing: 8) {
        SortChip(label: "By Rank", isOn: true,  action: {})
        SortChip(label: "A–Z",     isOn: false, action: {})
    }
    .padding()
    .background(Color(.appBackground))
}
