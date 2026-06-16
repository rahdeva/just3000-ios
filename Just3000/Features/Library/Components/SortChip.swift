import SwiftUI

struct SortChip: View {
    let label: String
    let isOn: Bool
    let action: () -> Void

    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 13, weight: isOn ? .semibold : .regular))
                .foregroundStyle(isOn ? .white : .secondary)
                .padding(.vertical, 7)
                .padding(.horizontal, 14)
                .background(isOn ? accent : Color(.systemFill))
                .clipShape(RoundedRectangle(cornerRadius: 8))
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
    .background(Color(.systemGroupedBackground))
}
