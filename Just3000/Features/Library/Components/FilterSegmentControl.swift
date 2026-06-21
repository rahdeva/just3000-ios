import SwiftUI

enum FilterControlStyle {
    case native   // v1: iOS segmented control
    case playful  // v2: custom playful style
}

struct FilterSegmentControl: View {
    @Binding var filter: LibraryFilter
    var style: FilterControlStyle = .playful

    var body: some View {
        switch style {
        case .native:
            Picker("Filter", selection: $filter) {
                ForEach(LibraryFilter.allCases, id: \.self) { f in
                    Text(f.rawValue).tag(f)
                }
            }
            .pickerStyle(.segmented)

        case .playful:
            HStack(spacing: 0) {
                ForEach(LibraryFilter.allCases, id: \.self) { f in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            filter = f
                        }
                    } label: {
                        Text(f.rawValue)
                            .font(AppTypography.PlusJakartaSans.footnote)
                            .fontWeight(.bold)
                            .foregroundStyle(filter == f ? .white : Color(.secondaryLabel))
                            .frame(maxWidth: .infinity)
                            .playfulCard(
                                backgroundColor: filter == f ? Color(.brandPrimary) : .clear,
                                borderColor: filter == f ? .primary : .clear,
                                shadowColor: filter == f ? .primary : .clear,
                                cornerRadius: 100,
                                borderWidth: 1.5,
                                shadowOffset: CGSize(width: 2, height: 2),
                                horizontalPadding: 0,
                                verticalPadding: 9
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.leading, 4)
            .padding(.top, 4)
            .padding(.bottom, 5)
            .padding(.trailing, 5)
            .background {
                Capsule()
                    .fill(Color(.systemBackground))
                    .overlay {
                        Capsule()
                            .strokeBorder(.primary, lineWidth: 1.5)
                    }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        FilterSegmentControl(filter: .constant(.all), style: .playful)
        FilterSegmentControl(filter: .constant(.all), style: .native)
    }
    .padding()
    .background(Color(.appBackground))
}
