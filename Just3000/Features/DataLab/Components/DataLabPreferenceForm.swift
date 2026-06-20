import SwiftUI

struct DataLabPreferenceForm: View {
    @Bindable var vm: DataLabViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                Text("Stored value: **\(vm.currentThemeMode.label)**")
                    .font(.subheadline)
            }

            Picker("Theme Mode", selection: $vm.selectedThemeMode) {
                ForEach(AppThemeMode.allCases, id: \.self) { mode in
                    Label(mode.label, systemImage: mode.icon).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            HStack(spacing: 12) {
                Button("Save") { vm.saveThemeMode() }
                    .buttonStyle(.borderedProminent)

                Button("Reset") { vm.resetThemeMode() }
                    .buttonStyle(.bordered)
                    .tint(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}
