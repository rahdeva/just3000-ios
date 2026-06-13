import SwiftUI

struct LibraryView: View {
    @Binding var path: NavigationPath
    @State private var libraryVM = LibraryViewModel()

    var body: some View {
        VStack {
            Text("Library")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Library")
    }
}

#Preview {
    NavigationStack {
        LibraryView(path: .constant(NavigationPath()))
    }
}
