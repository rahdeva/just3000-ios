import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @State private var homeVM = HomeViewModel()

    var body: some View {
        VStack {
            Text("Home")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Home")
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant(NavigationPath()))
    }
}
