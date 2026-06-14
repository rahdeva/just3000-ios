import SwiftUI

struct SettingView: View {
    @State private var settingVM = SettingViewModel()

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
