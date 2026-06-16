import SwiftUI

private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)
private let green  = Color(red: 52/255, green: 199/255, blue: 89/255)

struct SettingView: View {
    @State private var viewModel = SettingViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // MARK: Learning
                    SettingCard(title: "Learning") {
                        SettingStepperRow(
                            icon: "flag.fill", iconColor: accent,
                            label: "Daily goal",
                            value: "\(viewModel.dailyGoal) words",
                            onDecrement: { viewModel.dailyGoal = max(5,   viewModel.dailyGoal - 5) },
                            onIncrement: { viewModel.dailyGoal = min(100, viewModel.dailyGoal + 5) }
                        )
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "sparkles",             iconColor: .purple, label: "Algorithm",     value: "SM-2 Spaced Repetition")
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "arrow.up.circle.fill", iconColor: .blue,   label: "Starting rank", value: "#1")
                    }

                    // MARK: Language
                    SettingCard(title: "Language") {
                        SettingInfoRow(icon: "globe.americas.fill", iconColor: .blue,   label: "Learning",      value: "English 🇬🇧")
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "globe",               iconColor: .orange, label: "Translated to", value: "Indonesian 🇮🇩")
                    }

                    // MARK: Reminders
                    SettingCard(title: "Reminders") {
                        SettingToggleRow(icon: "bell.fill", iconColor: .red, label: "Daily reminder", isOn: $viewModel.reminderEnabled)
                        if viewModel.reminderEnabled {
                            Divider().padding(.leading, 52)
                            SettingInfoRow(icon: "clock.fill", iconColor: .orange, label: "Time", value: "8:00 PM")
                        }
                    }

                    // MARK: Sync
                    SettingCard(title: "Sync") {
                        SettingToggleRow(icon: "icloud.fill", iconColor: accent, label: "iCloud Sync", isOn: $viewModel.icloudEnabled)
                        Divider().padding(.leading, 52)
                        SettingInfoRow(
                            icon: "checkmark.circle.fill",
                            iconColor: viewModel.icloudEnabled ? green : Color(.tertiaryLabel),
                            label: "Status",
                            value: viewModel.icloudEnabled ? "Synced" : "Offline"
                        )
                    }

                    // MARK: Your Progress
                    SettingCard(title: "Your Progress") {
                        SettingInfoRow(icon: "flame.fill", iconColor: .orange, label: "Current streak", value: "\(viewModel.streak) days")
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "crown.fill", iconColor: .purple, label: "Best streak",    value: "\(viewModel.longest) days")
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "bolt.fill",  iconColor: Color(red: 255/255, green: 214/255, blue: 10/255),
                                       label: "Total XP", value: "\(viewModel.xp.formatted()) XP")
                    }

                    // MARK: About
                    SettingCard(title: "About") {
                        SettingInfoRow(icon: "info.circle.fill",    iconColor: .blue,  label: "Version",       value: "1.0.0")
                        Divider().padding(.leading, 52)
                        SettingInfoRow(icon: "books.vertical.fill", iconColor: accent, label: "Words in list", value: "3,000")
                    }

                    // MARK: Reset
                    Button { viewModel.showResetAlert = true } label: {
                        Text("Reset all progress")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
                    }
                    .buttonStyle(.plain)

                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Settings")
            .alert("Reset Progress", isPresented: $viewModel.showResetAlert) {
                Button("Reset", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will erase all your learning progress. This action cannot be undone.")
            }
        }
    }
}

#Preview {
    SettingView()
}
