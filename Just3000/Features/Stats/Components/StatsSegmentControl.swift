import SwiftUI

enum StatsTab: String, CaseIterable {
    case overview = "Overview"
    case weekly   = "Weekly"
    case calendar = "Calendar"
}

struct StatsSegmentControl: View {
    @Binding var tab: StatsTab

    var body: some View {
        Picker("Tab", selection: $tab) {
            ForEach(StatsTab.allCases, id: \.self) { t in
                Text(t.rawValue).tag(t)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    StatsSegmentControl(tab: .constant(.overview))
        .padding()
        .background(Color(.systemGroupedBackground))
}
