import SwiftUI

struct StatsView: View {
    @Binding var path: NavigationPath
    @State private var viewModel = StatsViewModel()
    @State private var tab: StatsTab = .overview

    var body: some View {
        VStack {
            PageHeader(
                title: "Stats"
            )
            
            StatsSegmentControl(tab: $tab)
                .padding(.horizontal, 16)
                    
            ScrollView {
                VStack(spacing: 0) {
                    Group {
                        switch tab {
                            case .overview: OverviewTab(viewModel: viewModel)
                            case .weekly:   WeeklyTab(viewModel: viewModel)
                            case .calendar: CalendarTab(viewModel: viewModel)
                        }
                    }
                    .padding(.top, 16)
                    .animation(.easeInOut(duration: 0.2), value: tab)
                }
                .padding(.bottom, 32)
            }
        }
        .dotGridBackground()
    }
}

#Preview {
    NavigationStack {
        StatsView(path: .constant(NavigationPath()))
    }
}
