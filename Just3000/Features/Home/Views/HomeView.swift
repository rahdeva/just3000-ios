import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good morning" }
        if hour < 18 { return "Good afternoon" }
        return "Good evening"
    }

    private var dateString: String {
        let f = DateFormatter()
        f.dateFormat = "EEEE, MMMM d"
        return f.string(from: Date())
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    HStack {
                        Text(dateString)
                            .font(.system(size: 15))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 2)
                    .padding(.bottom, 2)

                    DailyPracticeCard(viewModel: viewModel)

                    MasteryRingCard(viewModel: viewModel)

                    HStack(spacing: 12) {
                        StatCard(value: "\(viewModel.streak)",   label: "Day streak",  icon: "flame.fill",            color: .orange)
                        StatCard(value: "\(viewModel.longest)",  label: "Best streak", icon: "crown.fill",            color: .purple)
                        StatCard(value: "\(viewModel.sessions)", label: "Sessions",    icon: "checkmark.circle.fill", color: Color(red: 52/255, green: 199/255, blue: 89/255))
                    }
                    .padding(.horizontal, 16)

                    ReviewNudgeRow(dueCount: viewModel.dueCount)
                }
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(greeting)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    StreakPill(streak: viewModel.streak)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
