import SwiftUI

struct MasteryRingCard: View {
    let viewModel: HomeViewModel

    private let stages: [(key: String, label: String, color: Color)] = [
        ("mastered", "Mastered", .brandPrimary),
        ("mature",   "Mature",   .brandQuaternary),
        ("young",    "Young",    .info),
        ("learning", "Learning", .brandTertiary),
    ]

    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            MasteryRing(
                pct: (Double(viewModel.masteredCount) / Double(max(1, viewModel.total))) * 100,
                masteredCount: viewModel.masteredCount,
                total: viewModel.total
            )
            .frame(width: 110, height: 110)

            VStack(alignment: .leading, spacing: 0) {
                Text("Vocabulary progress")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                    .padding(.bottom, 10)

                ForEach(stages, id: \.key) { stage in
                    HStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(stage.color)
                            .frame(width: 8, height: 8)
                        Text(stage.label)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text((viewModel.stageCounts[stage.key] ?? 0).formatted())
                            .font(.system(size: 13, weight: .semibold).monospacedDigit())
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom, 7)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadowPrimary()
        .padding(.horizontal, 16)
    }
}

// MARK: - MasteryRing
private struct MasteryRing: View {
    let pct: Double
    let masteredCount: Int
    let total: Int

    @State private var animated: Double = 0

    private let strokeWidth: CGFloat = 10
    private let accent = Color(red: 94/255, green: 92/255, blue: 230/255)

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemFill), lineWidth: strokeWidth)
            Circle()
                .trim(from: 0, to: animated / 100)
                .stroke(.brandPrimary, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))

            VStack(spacing: 1) {
                Text("\(Int(animated))%")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)
                    .monospacedDigit()
                Text("mastered")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                Text("\(masteredCount.formatted()) / 3,000")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animated = pct
            }
        }
    }
}

#Preview {
    MasteryRingCard(viewModel: HomeViewModel())
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
