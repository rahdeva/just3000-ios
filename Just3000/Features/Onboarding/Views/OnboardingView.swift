import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(GeneralViewModel.self) private var generalVM
    @State private var step: OnboardingStep = .welcome

    enum OnboardingStep {
        case welcome, level, goal, notifications, icloud
    }

    var body: some View {
        ZStack {
            Color(.appBackground).ignoresSafeArea()

            switch step {
                case .welcome:
                    WelcomeStep { withAnimation { step = .level } }
                        .slideTransition()
                case .level:
                    LevelStep { level in
                        generalVM.studyLevel = level
                        withAnimation { step = .goal }
                    }
                    .slideTransition()
                case .goal:
                    GoalStep { goal in
                        generalVM.dailyGoal = goal
                        withAnimation { step = .notifications }
                    }
                    .slideTransition()
                case .notifications:
                    NotifStep { withAnimation { step = .icloud } }
                    .slideTransition()
                case .icloud:
                    ICloudStep {
                        generalVM.completeOnboarding(level: generalVM.studyLevel, goal: generalVM.dailyGoal)
                    }
                    .slideTransition()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: step)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if step == .welcome {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation { step = .welcome }
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    OnboardingView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
