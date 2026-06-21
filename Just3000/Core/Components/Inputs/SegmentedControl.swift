import SwiftUI

enum SegmentedControlStyle {
    case native   // v1: iOS segmented control
    case playful  // v2: custom playful style
}

struct SegmentedControl<T: Hashable>: View {
    @Binding var selection: T

    let items: [T]
    let label: (T) -> String
    var style: SegmentedControlStyle = .playful

    private var selectedIndex: Int {
        items.firstIndex(of: selection) ?? 0
    }

    var body: some View {
        switch style {
        case .native:
            nativeSegmentedControl

        case .playful:
            playfulSegmentedControl
        }
    }

    private var nativeSegmentedControl: some View {
        Picker("", selection: $selection) {
            ForEach(items, id: \.self) { item in
                Text(label(item))
                    .tag(item)
            }
        }
        .pickerStyle(.segmented)
    }

    private var playfulSegmentedControl: some View {
        ZStack(alignment: .leading) {
            playfulSlidingIndicator

            playfulButtons
        }
        .padding(.leading, 4)
        .padding(.top, 4)
        .padding(.bottom, 5)
        .padding(.trailing, 5)
        .background {
            playfulBackground
        }
    }

    private var playfulSlidingIndicator: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width / CGFloat(items.count)

            playfulSelectedIndicator
                .frame(width: itemWidth)
                .offset(x: itemWidth * CGFloat(selectedIndex))
                .animation(
                    .spring(response: 0.3, dampingFraction: 0.7),
                    value: selection
                )
        }
    }

    private var playfulSelectedIndicator: some View {
        Color.clear
            .playfulCard(
                backgroundColor: Color(.brandPrimary),
                borderColor: .primary,
                shadowColor: .primary,
                cornerRadius: 100,
                borderWidth: 1.5,
                shadowOffset: CGSize(width: 2, height: 2),
                horizontalPadding: 0,
                verticalPadding: 9
            )
    }

    private var playfulButtons: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                playfulButton(for: item)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func playfulButton(for item: T) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selection = item
            }
        } label: {
            Text(label(item))
                .font(AppTypography.PlusJakartaSans.footnote)
                .fontWeight(.bold)
                .foregroundStyle(selection == item ? .white : Color(.secondaryLabel))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(.clear)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var playfulBackground: some View {
        Capsule()
            .fill(Color(.systemBackground))
            .overlay {
                Capsule()
                    .strokeBorder(.primary, lineWidth: 1.5)
            }
    }
}

private enum SegmentedControlPreviewTab: String, CaseIterable {
    case all = "All"
    case learning = "Learning"
    case mastered = "Mastered"
}

#Preview {
    @Previewable @State var selection: SegmentedControlPreviewTab = .all

    VStack(spacing: 16) {
        SegmentedControl(
            selection: $selection,
            items: SegmentedControlPreviewTab.allCases,
            label: { $0.rawValue },
            style: .playful
        )

        SegmentedControl(
            selection: $selection,
            items: SegmentedControlPreviewTab.allCases,
            label: { $0.rawValue },
            style: .native
        )
    }
    .padding()
    .background(Color(.appBackground))
}
