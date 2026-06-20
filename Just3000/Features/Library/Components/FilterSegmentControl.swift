import SwiftUI

struct FilterSegmentControl: View {
    @Binding var filter: LibraryFilter

    var body: some View {
        Picker("Filter", selection: $filter) {
            ForEach(LibraryFilter.allCases, id: \.self) { f in
                Text(f.rawValue).tag(f)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    FilterSegmentControl(filter: .constant(.all))
        .padding()
        .background(Color(.systemGroupedBackground))
}
