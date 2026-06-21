import SwiftUI
import SwiftData

struct SettingView: View {
    @Binding var path: NavigationPath
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = SettingViewModel()

    private let green = Color(red: 52 / 255, green: 199 / 255, blue: 89 / 255)

    var body: some View {
        VStack(spacing: 0){
            PageHeader(
                title: "Setting",
            )

            ScrollView {
                VStack(spacing: 24) {
                    // MARK: Learning
                    SettingCard(title: "Learning") {
                        SettingStepperRow(
                            icon: "flag.fill",
                            iconColor: Color(.brandPrimary),
                            label: "Daily goal",
                            value: "\(viewModel.dailyGoal)",
                            onDecrement: {
                                viewModel.dailyGoal = max(
                                    5,
                                    viewModel.dailyGoal - 5
                                )
                            },
                            onIncrement: {
                                viewModel.dailyGoal = min(
                                    100,
                                    viewModel.dailyGoal + 5
                                )
                            }
                        )
                        Divider()
                        SettingInfoRow(
                            icon: "sparkles",
                            iconColor: .purple,
                            label: "Algorithm",
                            value: "SM-2 Spaced Repetition"
                        )
                    }

                    // MARK: Language
                    SettingCard(title: "Language") {
                        SettingInfoRow(
                            icon: "globe.americas.fill",
                            iconColor: .blue,
                            label: "Learning",
                            value: "English 🇬🇧"
                        )
                        Divider()
                        SettingInfoRow(
                            icon: "globe",
                            iconColor: .orange,
                            label: "Translated to",
                            value: "Indonesian 🇮🇩"
                        )
                    }

                    // MARK: Reminders
                    SettingCard(title: "Reminders") {
                        SettingToggleRow(
                            icon: "bell.fill",
                            iconColor: .red,
                            label: "Daily reminder",
                            isOn: $viewModel.reminderEnabled
                        )
                        if viewModel.reminderEnabled {
                            Divider()
                            SettingInfoRow(
                                icon: "clock.fill",
                                iconColor: .orange,
                                label: "Time",
                                value: "8:00 PM"
                            )
                        }
                    }

                    // MARK: Sync
                    SettingCard(title: "Sync") {
                        SettingToggleRow(
                            icon: "icloud.fill",
                            iconColor: Color(.brandPrimary),
                            label: "iCloud Sync",
                            isOn: $viewModel.icloudEnabled
                        )
                        Divider()
                        SettingInfoRow(
                            icon: "checkmark.circle.fill",
                            iconColor: viewModel.icloudEnabled
                                ? green : Color(.tertiaryLabel),
                            label: "Status",
                            value: viewModel.icloudEnabled
                                ? "Synced" : "Offline"
                        )
                    }

                    // MARK: About
                    SettingCard(title: "About") {
                        SettingInfoRow(
                            icon: "info.circle.fill",
                            iconColor: .blue,
                            label: "Version",
                            value: "1.0.0"
                        )
                        Divider()
                        SettingLinkRow(
                            icon: "hand.raised.fill",
                            iconColor: .blue,
                            label: "Privacy Policy",
                            url: URL(string: "https://just3000.app/privacy")!
                        )
                        Divider()
                        SettingLinkRow(
                            icon: "doc.text.fill",
                            iconColor: Color(.brandPrimary),
                            label: "Terms & Conditions",
                            url: URL(string: "https://just3000.app/terms")!
                        )
                    }

                    // MARK: Reset
                    Button("Reset all progress") {
                        viewModel.showResetAlert = true
                    }
                    .buttonStyle(
                        PlayfulButtonStyle(
                            backgroundColor: .white,
                            foregroundColor: .red,
                            borderColor: .red,
                            shadowColor: .red,
                            cornerRadius: 16,
                            borderWidth: 2,
                            shadowHeight: 4
                        )
                    )

                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .padding(.bottom, 16)
            }
            .alert("Reset Progress", isPresented: $viewModel.showResetAlert) {
                Button("Reset", role: .destructive) {
                    viewModel.resetProgress()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(
                    "This will erase all your learning progress. This action cannot be undone."
                )
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
        SettingView(path: .constant(NavigationPath()))
    }
    .modelContainer(container)
}
