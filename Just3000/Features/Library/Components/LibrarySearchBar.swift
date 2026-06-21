import SwiftUI

struct LibrarySearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.secondary)
            TextField("Search words...", text: $text)
                .font(AppTypography.PlusJakartaSans.body)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.brandPrimary)
                        .font(.system(size: 16))
                }
            }
        }
        .playfulCard(
            backgroundColor: .white,
            borderColor: .primary,
            shadowColor: .primary,
            cornerRadius: 100,
            borderWidth: 2,
            horizontalPadding: 14,
            verticalPadding: 11
        )
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

#Preview {
    VStack {
        LibrarySearchBar(text: .constant(""))
        LibrarySearchBar(text: .constant("hello"))
    }
    .padding(.vertical)
    .background(Color(.appBackground))
}
