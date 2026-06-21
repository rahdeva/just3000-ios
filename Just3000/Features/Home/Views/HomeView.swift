import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PageHeader(
                    title: Date().greeting,
                    subtitle: Date().formattedDay,
                    trailing: {
                        StreakPill(streak: viewModel.streak)
                    }
                )
                .padding(.bottom, 16)

                VStack(spacing: 16) {
                    DailyPracticeCard(viewModel: viewModel, path: $path)

                    MasteryRingCard(viewModel: viewModel)

                    HStack(spacing: 16) {
                        StatCard(
                            value: "\(viewModel.streak)",
                            label: "Day streak",
                            icon: "flame.fill",
                            color: .orange
                        )
                        StatCard(
                            value: "\(viewModel.longest)",
                            label: "Best streak",
                            icon: "crown.fill",
                            color: .purple
                        )
                        StatCard(
                            value: "\(viewModel.sessions)",
                            label: "Sessions",
                            icon: "checkmark.circle.fill",
                            color: Color(
                                red: 52 / 255,
                                green: 199 / 255,
                                blue: 89 / 255
                            )
                        )
                    }
                    .padding(.horizontal, 16)

                    // ReviewNudgeRow(dueCount: viewModel.dueCount, path: $path)
                }
                .padding(.bottom, 32)
            }
        }
        .background(Color.appBackground)
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant(NavigationPath()))
    }
}
