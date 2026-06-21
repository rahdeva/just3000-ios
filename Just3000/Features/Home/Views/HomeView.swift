import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var path: NavigationPath
    @Environment(\.modelContext) private var modelContext
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

                    ReviewNudgeRow(dueCount: viewModel.dueCount, path: $path)

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
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 32)
            }
        }
        .dotGridBackground()
        .onAppear {
            viewModel.load(context: modelContext)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: WordProgress.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    NavigationStack {
        HomeView(path: .constant(NavigationPath()))
    }
    .modelContainer(container)
}
