import SwiftUI

struct WeeklyTab: View {
    let viewModel: StatsViewModel

    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)
    private let green  = Color(red: 52/255,  green: 199/255, blue: 89/255)

    var body: some View {
        VStack(spacing: 12) {
            // Summary + chart card
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("This week")
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("\(viewModel.thisWeekTotal)")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.primary)
                            Text("words")
                                .font(.system(size: 15))
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    DeltaBadge(delta: viewModel.weekDelta)
                        .padding(.top, 6)
                }
                .padding(.bottom, 20)

                WeeklyBarChart(
                    days: viewModel.weekDays,
                    thisWeek: viewModel.thisWeek,
                    lastWeek: viewModel.lastWeek
                )

                HStack(spacing: 16) {
                    Spacer()
                    LegendDot(color: accent,              label: "This week")
                    LegendDot(color: Color(.systemFill),  label: "Last week")
                }
                .padding(.top, 14)
            }
            .padding(18)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadowPrimary()

            HStack(spacing: 12) {
                StatCard(value: "\(viewModel.dailyAverage)", label: "Daily average", icon: "chart.bar.fill", color: accent)
                StatCard(value: "\(viewModel.bestDay)",      label: "Best day",      icon: "star.fill",      color: green)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - DeltaBadge
private struct DeltaBadge: View {
    let delta: Int

    private var positive: Bool { delta >= 0 }
    private var green: Color { Color(red: 52/255, green: 199/255, blue: 89/255) }
    private var red: Color   { Color(red: 255/255, green: 59/255, blue: 48/255) }

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: positive ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 12, weight: .semibold))
            Text("\(positive ? "+" : "")\(delta)")
                .font(.system(size: 14, weight: .semibold))
        }
        .foregroundStyle(positive ? green : red)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background((positive ? green : red).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - LegendDot
private struct LegendDot: View {
    let color: Color
    let label: String

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: 10, height: 10)
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - WeeklyBarChart
private struct WeeklyBarChart: View {
    let days: [String]
    let thisWeek: [Int]
    let lastWeek: [Int]

    @State private var animated = false

    private let chartHeight: CGFloat = 110
    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

    private var maxVal: CGFloat {
        CGFloat(max(thisWeek.max() ?? 1, lastWeek.max() ?? 1, 1))
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(days.indices, id: \.self) { i in
                VStack(spacing: 6) {
                    HStack(alignment: .bottom, spacing: 3) {
                        bar(value: lastWeek[i], color: Color(.systemFill))
                        bar(value: thisWeek[i], color: accent)
                    }
                    .frame(height: chartHeight)

                    Text(days[i])
                        .font(.system(size: 11))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.1)) {
                animated = true
            }
        }
    }

    @ViewBuilder
    private func bar(value: Int, color: Color) -> some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(height: animated ? max(2, chartHeight * CGFloat(value) / maxVal) : 2)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeeklyTab(viewModel: StatsViewModel())
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
