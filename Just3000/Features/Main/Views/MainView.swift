//
//  MainView.swift
//  Just3000
//
//  Created by rahdeva on 12/06/26.
//
import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(GeneralViewModel.self) private var generalVM
    @State private var isSplashPresented: Bool = true
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if isSplashPresented {
                    SplashView(isPresented: $isSplashPresented)
                } else if !generalVM.hasCompletedOnboarding {
                    OnboardingView()
                } else {
                    AdaptiveLayoutView(path: $path)
                }
            }
            .registerRoutes(path: $path)
        }
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
