import SwiftUI

struct ProgressView: View {
    @Binding var path: NavigationPath
    @State private var progressVM = ProgressViewModel()

    var body: some View {
        VStack {
            Text("Progress")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Progress")
    }
}

#Preview {
    NavigationStack {
        ProgressView(path: .constant(NavigationPath()))
    }
}
