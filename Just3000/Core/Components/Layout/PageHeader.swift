import SwiftUI

struct PageHeader: View {
    let title: String
    let subtitle: String?
    let trailing: AnyView?

    init(
        title: String,
        subtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = nil
    }

    init<Trailing: View>(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = AnyView(trailing())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                if let trailing {
                    trailing
                }
            }

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}
