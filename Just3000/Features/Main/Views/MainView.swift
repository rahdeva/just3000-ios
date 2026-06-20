import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(GeneralViewModel.self) private var generalVM
    @State private var isSplashPresented: Bool = true

    var body: some View {
        Group {
            if isSplashPresented {
                SplashView(isPresented: $isSplashPresented)
                    .transition(.opacity)
            } else if !generalVM.hasCompletedOnboarding {
                OnboardingView()
                    .transition(.opacity)
            } else {
                AdaptiveLayoutView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isSplashPresented)
        .animation(.easeInOut(duration: 0.3), value: generalVM.hasCompletedOnboarding)
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    MainView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
