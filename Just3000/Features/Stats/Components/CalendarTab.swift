import SwiftUI

struct CalendarTab: View {
    let viewModel: StatsViewModel
    @State private var selectedIndex: Int? = nil

    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

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
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(viewModel.activeDays) active days")
                    .font(.system(size: 12, design: .monospaced))
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

            // Legend
            HStack(spacing: 4) {
                Spacer()
                Text("Less")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.tertiaryLabel))
                ForEach(0..<5, id: \.self) { v in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(cellColor(v))
                        .frame(width: 10, height: 10)
                }
                Text("More")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
        }
        .padding(18)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 1)
    }

    // MARK: - Selected day detail
    private var selectedDayCard: some View {
        Group {
            if let idx = selectedIndex {
                let val = idx < viewModel.heatmap.count ? viewModel.heatmap[idx] : 0
                VStack(alignment: .leading, spacing: 4) {
                    Text("Day \(idx + 1) of 84")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                    Text(val == 0 ? "Rest day 😴" : "\(val * 4) words studied")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.primary)
                    if val > 0 {
                        Text("\(Int(Double(val) * 3.2)) correct · \(val) session\(val > 1 ? "s" : "")")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.opacity.combined(with: .scale(scale: 0.98)))
            } else {
                Text("Tap a day to see details")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
    }

    private func cellColor(_ v: Int) -> Color {
        v == 0 ? Color(.systemFill) : accent.opacity(0.2 + Double(v) * 0.18)
    }
}

#Preview {
    CalendarTab(viewModel: StatsViewModel())
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
