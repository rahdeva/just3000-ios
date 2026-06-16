import SwiftUI

struct StatsView: View {
    @State private var viewModel = StatsViewModel()
    @State private var tab: StatsTab = .overview

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    StatsSegmentControl(tab: $tab)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 14)

                    Group {
                        switch tab {
                        case .overview: OverviewTab(viewModel: viewModel)
                        case .weekly:   WeeklyTab(viewModel: viewModel)
                        case .calendar: CalendarTab(viewModel: viewModel)
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: tab)
                }
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Progress")
        }
    }
}

#Preview {
    StatsView()
}
