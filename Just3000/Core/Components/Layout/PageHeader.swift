import SwiftUI

struct PageHeader<Trailing: View>: View {
    let title: String
    let subtitle: String?
    let trailing: Trailing

    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AppTypography.Outfit.title1)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    if let subtitle {
                        Text(subtitle.uppercased())
                            .font(AppTypography.PlusJakartaSans.caption1)
                            .fontWeight(.bold)
                            .tracking(2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 12)

                HStack(alignment: .center, spacing: 10) {
                    trailing
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}

// MARK: - Empty Trailing

extension PageHeader where Trailing == EmptyView {
    init(
        title: String,
        subtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = EmptyView()
    }
}
