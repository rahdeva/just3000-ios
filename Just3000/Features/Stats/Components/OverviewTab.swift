import SwiftUI

struct OverviewTab: View {
    let viewModel: StatsViewModel

    var body: some View {
        VStack(spacing: 16) {
            ringCard
            HStack(spacing: 16) {
                StatCard(value: "\(viewModel.streak)",  label: "Current streak", icon: "flame.fill",  color: .orange)
                StatCard(value: "\(viewModel.longest)", label: "Best streak",    icon: "crown.fill",  color: .purple)
            }
            HStack(spacing: 16) {
                StatCard(value: "\(viewModel.sessions)", label: "Sessions",  icon: "checkmark.circle.fill", color: Color(red: 52/255, green: 199/255, blue: 89/255))
                StatCard(value: viewModel.xp.formatted(), label: "XP earned", icon: "bolt.fill",            color: .orange)
            }
            MemoryStagesCard(stageCounts: viewModel.stageCounts)
        }
        .padding(.horizontal, 16)
    }

    private var ringCard: some View {
        VStack(spacing: 10) {
            StatsRing(
                pct: viewModel.masteryPct,
                masteredCount: viewModel.masteredCount,
                total: viewModel.total
            )
            .frame(width: 160, height: 160)

            Text("\((viewModel.total - viewModel.masteredCount).formatted()) words remaining")
                .font(.system(size: 13, design: .monospaced))
                .foregroundStyle(Color(.tertiaryLabel))
        }
        .frame(maxWidth: .infinity)
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadowPrimary()
    }
}

// MARK: - StatsRing
private struct StatsRing: View {
    let pct: Double
    let masteredCount: Int
    let total: Int

    @State private var animated: Double = 0

    private let strokeWidth: CGFloat = 14
    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemFill), lineWidth: strokeWidth)
            Circle()
                .trim(from: 0, to: animated / 100)
                .stroke(accent, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 2) {
                Text("\(Int(pct))%")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.primary)
                    .monospacedDigit()
                Text("mastered")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                Text("\(masteredCount.formatted()) of 3,000")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) { animated = pct }
        }
    }
}

// MARK: - MemoryStagesCard
private struct MemoryStagesCard: View {
    let stageCounts: [String: Int]

    private let stageOrder: [(key: String, label: String, color: Color)] = [
        ("new",      "New",      Color(red: 142/255, green: 142/255, blue: 147/255)),
        ("learning", "Learning", Color(red: 255/255, green: 149/255, blue: 0)),
        ("young",    "Young",    Color(red: 0,       green: 122/255, blue: 1)),
        ("mature",   "Mature",   Color(red: 175/255, green: 82/255,  blue: 222/255)),
        ("mastered", "Mastered", Color(red: 52/255,  green: 199/255, blue: 89/255)),
    ]

    private var stageTotals: Int {
        stageOrder.reduce(0) { $0 + (stageCounts[$1.key] ?? 0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Memory stages")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.primary)
                .padding(.bottom, 14)

            // Stacked proportional bar
            GeometryReader { geo in
                HStack(spacing: 2) {
                    ForEach(stageOrder, id: \.key) { stage in
                        let count = stageCounts[stage.key] ?? 0
                        let frac  = Double(count) / Double(max(1, stageTotals))
                        Rectangle()
                            .fill(stage.color)
                            .frame(width: max(0, geo.size.width * frac - 2))
                    }
                }
            }
            .frame(height: 8)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding(.bottom, 16)

            // 2-column legend
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(stageOrder, id: \.key) { stage in
                    HStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(stage.color)
                            .frame(width: 8, height: 8)
                        Text(stage.label)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text((stageCounts[stage.key] ?? 0).formatted())
                            .font(.system(size: 13, weight: .semibold).monospacedDigit())
                            .foregroundStyle(.primary)
                    }
                }
            }
            .padding(.bottom, 16)

            // Per-stage progress bars (mastered → new)
            VStack(spacing: 10) {
                ForEach(Array(stageOrder.reversed()), id: \.key) { stage in
                    let count = stageCounts[stage.key] ?? 0
                    let pct   = Double(count) / Double(max(1, stageTotals)) * 100
                    VStack(spacing: 4) {
                        HStack {
                            Text(stage.label)
                                .font(.system(size: 13))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(pct))%")
                                .font(.system(size: 12, design: .monospaced))
                                .foregroundStyle(Color(.tertiaryLabel))
                        }
                        StageProgressBar(pct: pct, color: stage.color)
                    }
                }
            }
        }
        .padding(18)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadowPrimary()
    }
}

// MARK: - StageProgressBar
private struct StageProgressBar: View {
    let pct: Double
    let color: Color
    @State private var animated: Double = 0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3).fill(Color(.systemFill))
                RoundedRectangle(cornerRadius: 3)
                    .fill(color)
                    .frame(width: geo.size.width * (animated / 100))
            }
        }
        .frame(height: 5)
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) { animated = pct }
        }
    }
}

#Preview {
    ScrollView {
        OverviewTab(viewModel: StatsViewModel())
            .padding(.vertical)
    }
    .background(Color(.systemGroupedBackground))
}
