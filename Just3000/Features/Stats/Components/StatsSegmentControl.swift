import SwiftUI

enum StatsTab: String, CaseIterable {
    case overview = "Overview"
    case weekly   = "Weekly"
    case calendar = "Calendar"
}

struct StatsSegmentControl: View {
    @Binding var tab: StatsTab

    var body: some View {
        HStack(spacing: 2) {
            ForEach(StatsTab.allCases, id: \.self) { t in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { tab = t }
                } label: {
                    Text(t.rawValue)
                        .font(.system(size: 13, weight: tab == t ? .semibold : .regular))
                        .foregroundStyle(tab == t ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(tab == t ? Color.white : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .shadow(color: tab == t ? .black.opacity(0.12) : .clear, radius: 2, x: 0, y: 1)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(2)
        .background(Color(.systemFill))
        .clipShape(RoundedRectangle(cornerRadius: 9))
    }
}

#Preview {
    StatsSegmentControl(tab: .constant(.overview))
        .padding()
        .background(Color(.systemGroupedBackground))
}
