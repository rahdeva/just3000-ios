import SwiftUI

struct DataLabStoragePicker: View {
    @Binding var selected: DataLabStorageType
    let onSelect: (DataLabStorageType) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(DataLabStorageType.allCases) { type in
                    Button {
                        selected = type
                        onSelect(type)
                    } label: {
                        Label(type.rawValue, systemImage: type.icon)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(selected == type ? Color.accentColor : Color(.systemGray5))
                            .foregroundStyle(selected == type ? .white : .primary)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}
