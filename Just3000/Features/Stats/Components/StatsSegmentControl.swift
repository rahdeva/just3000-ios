import SwiftUI

enum StatsTab: String, CaseIterable {
    case overview = "Overview"
    case weekly   = "Weekly"
    case calendar = "Calendar"
}

struct StatsSegmentControl: View {
    @Binding var tab: StatsTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(StatsTab.allCases, id: \.self) { item in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        tab = item
                    }
                } label: {
                    Text(item.rawValue)
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(tab == item ? .white : Color(.secondaryLabel))
                        .frame(maxWidth: .infinity)
                        .playfulCard(
                            backgroundColor: tab == item ? Color(.brandPrimary) : .clear,
                            borderColor: tab == item ? .primary : .clear,
                            shadowColor: tab == item ? .primary : .clear,
                            cornerRadius: 100,
                            borderWidth: 1.5,
                            shadowOffset: CGSize(width: 2, height: 2),
                            horizontalPadding: 0,
                            verticalPadding: 9
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.leading, 4)
        .padding(.top, 4)
        .padding(.bottom, 5)
        .padding(.trailing, 5)
        .background {
            Capsule()
                .fill(Color(.systemBackground))
                .overlay {
                    Capsule()
                        .strokeBorder(.primary, lineWidth: 1.5)
                }
        }
    }
}

#Preview {
    @Previewable @State var tab: StatsTab = .overview
    StatsSegmentControl(tab: $tab)
        .padding()
        .background(Color(.appBackground))
}
