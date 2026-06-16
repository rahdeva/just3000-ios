import SwiftUI

struct FilterSegmentControl: View {
    @Binding var filter: LibraryFilter

    var body: some View {
        HStack(spacing: 2) {
            ForEach(LibraryFilter.allCases, id: \.self) { f in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { filter = f }
                } label: {
                    Text(f.rawValue)
                        .font(.system(size: 13, weight: filter == f ? .semibold : .regular))
                        .foregroundStyle(filter == f ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(filter == f ? Color.white : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .shadow(color: filter == f ? .black.opacity(0.12) : .clear, radius: 2, x: 0, y: 1)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(2)
        .background(Color(.systemFill))
        .clipShape(RoundedRectangle(cornerRadius: 9))
    }
}

#Preview {
    FilterSegmentControl(filter: .constant(.all))
        .padding()
        .background(Color(.systemGroupedBackground))
}
