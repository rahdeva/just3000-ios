import SwiftUI

struct CalendarTab: View {
    let viewModel: StatsViewModel
    @State private var selectedIndex: Int? = nil

    private let accent = Color(.brandPrimary)

    private var startDate: Date {
        Calendar.current.date(byAdding: .day, value: -83, to: Date()) ?? Date()
    }

    private func date(for idx: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: idx, to: startDate) ?? startDate
    }

    var body: some View {
        VStack(spacing: 12) {
            heatmapCard
            selectedDayCard
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Heatmap
    private var heatmapCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Last 12 weeks")
                    .font(AppTypography.Outfit.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(viewModel.activeDays) active days")
                    .font(AppTypography.SFMono.caption1)
                    .foregroundStyle(Color(.tertiaryLabel))
            }

            // 12 cols × 7 rows grid
            HStack(spacing: 3) {
                ForEach(0..<12, id: \.self) { col in
                    VStack(spacing: 3) {
                        ForEach(0..<7, id: \.self) { row in
                            let idx        = col * 7 + row
                            let val        = idx < viewModel.heatmap.count ? viewModel.heatmap[idx] : 0
                            let isSelected = selectedIndex == idx
                            Button {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    selectedIndex = isSelected ? nil : idx
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(cellColor(val))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(isSelected ? accent : Color.clear, lineWidth: 1.5)
                                    )
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }

            // Legend — representative word counts: 0, 5, 10, 15, 20+
            HStack(spacing: 4) {
                Spacer()
                Text("Less")
                    .font(AppTypography.PlusJakartaSans.caption2)
                    .foregroundStyle(Color(.tertiaryLabel))
                ForEach([0, 5, 10, 15, 20], id: \.self) { v in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(cellColor(v))
                        .frame(width: 10, height: 10)
                }
                Text("More")
                    .font(AppTypography.PlusJakartaSans.caption2)
                    .foregroundStyle(Color(.tertiaryLabel))
            }
        }
        .playfulCard(
            cornerRadius: 20,
            borderWidth: 2,
            horizontalPadding: 18,
            verticalPadding: 18
        )
    }

    // MARK: - Selected day detail
    private var selectedDayCard: some View {
        Group {
            if let idx = selectedIndex {
                let val = idx < viewModel.heatmap.count ? viewModel.heatmap[idx] : 0
                VStack(alignment: .leading, spacing: 4) {
                    Text(date(for: idx).formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day().year()))
                        .font(AppTypography.PlusJakartaSans.footnote)
                        .foregroundStyle(.secondary)
                    Text(val == 0 ? "Rest day 😴" : "\(val) word\(val == 1 ? "" : "s") studied")
                        .font(AppTypography.Outfit.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.opacity.combined(with: .scale(scale: 0.98)))
            } else {
                Text("Tap a day to see details")
                    .font(AppTypography.PlusJakartaSans.callout)
                    .foregroundStyle(Color(.tertiaryLabel))
                    .frame(maxWidth: .infinity)
            }
        }
        .playfulCard(
            cornerRadius: 16,
            borderWidth: 2,
            horizontalPadding: 16,
            verticalPadding: 16
        )
    }

    private func cellColor(_ v: Int) -> Color {
        guard v > 0 else { return Color(.systemFill) }
        // Map word count → opacity: 1–4 → 0.38, 5–9 → 0.56, 10–14 → 0.74, 15+ → 0.92
        let intensity: Double
        switch v {
        case 1..<5:  intensity = 0.38
        case 5..<10: intensity = 0.56
        case 10..<15: intensity = 0.74
        default:     intensity = 0.92
        }
        return accent.opacity(intensity)
    }
}

#Preview {
    CalendarTab(viewModel: StatsViewModel())
        .padding(.vertical)
        .dotGridBackground()
}
