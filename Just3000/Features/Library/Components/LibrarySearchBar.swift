import SwiftUI

struct LibrarySearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.secondary)
            TextField("Search words…", text: $text)
                .font(.system(size: 17))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.brandPrimary)
                        .font(.system(size: 15))
                }
            }
        }
        .padding(.vertical, 9)
        .padding(.horizontal, 12)
        .background(Color(.secondarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadowPrimary()
        .padding(.horizontal, 16)
    }
}

#Preview {
    LibrarySearchBar(text: .constant("hello"))
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
