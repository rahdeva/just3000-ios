import SwiftUI

struct ChoiceRow: View {
    var badge: String? = nil
    let title: String
    let subtitle: String
    let selected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                if let badge {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selected ? Color(.brandPrimary) : Color(.gray))
                        .frame(width: 42, height: 42)
                        .overlay(Text(badge).font(.system(size: 13, weight: .semibold, design: .monospaced))
                            .foregroundStyle(selected ? .white : Color(.neutralSlate)))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.system(size: 17, weight: .medium)).foregroundStyle(Color(.neutralDarkSlate))
                    Text(subtitle).font(.system(size: 13)).foregroundStyle(Color(.neutralSlate))
                }
                Spacer()
                ZStack {
                    Circle().fill(selected ? Color(.brandPrimary) : .clear)
                        .overlay(Circle().stroke(selected ? Color(.brandPrimary) : Color(.lightGray), lineWidth: 2))
                        .frame(width: 22, height: 22)
                    if selected { Image(systemName: "checkmark").font(.system(size: 11, weight: .bold)).foregroundStyle(.white) }
                }
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(selected ? Color(.brandPrimary).opacity(0.08) : Color(.offWhite), in: RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(selected ? Color(.brandPrimary) : Color(.lightGray), lineWidth: 1.5))
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: selected)
    }
}
