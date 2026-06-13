import SwiftUI

struct PracticeView: View {
    @Binding var path: NavigationPath
    @State private var practiceVM = PracticeViewModel()

    var body: some View {
        VStack {
            Text("Practice")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Practice")
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
