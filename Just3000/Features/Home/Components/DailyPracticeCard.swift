import SwiftUI

struct DailyPracticeCard: View {
    let viewModel: HomeViewModel

    private let accentIndigo = Color(red: 94/255, green: 92/255, blue: 230/255)
    private let accentGreen  = Color(red: 52/255, green: 199/255, blue: 89/255)

    private var cardColor: Color { viewModel.questDone ? accentGreen : accentIndigo }
    private var buttonFg: Color  { viewModel.questDone ? accentGreen : accentIndigo }
    private var progress: Double { min(1.0, Double(viewModel.doneToday) / Double(max(1, viewModel.goal))) }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(viewModel.questDone ? "Daily goal reached 🎉" : "Daily practice")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.white.opacity(0.75))
                    let remaining = viewModel.goal - viewModel.doneToday
                    Text(viewModel.questDone ? "Great work today!" : "\(remaining) word\(remaining != 1 ? "s" : "") to go")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("\(viewModel.doneToday)/\(viewModel.goal)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 12)
                    .background(.white.opacity(0.22))
                    .clipShape(Capsule())
            }

            DailyProgressBar(progress: progress)

            Button { } label: {
                HStack(spacing: 8) {
                    Image(systemName: viewModel.questDone ? "checkmark" : "bolt.fill")
                        .font(.system(size: 16, weight: .semibold))
                    Text(viewModel.questDone ? "Continue practicing" : viewModel.doneToday > 0 ? "Continue" : "Start Practice")
                        .font(.system(size: 17, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .background(.white)
                .foregroundStyle(buttonFg)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
    }
}

// MARK: - DailyProgressBar
private struct DailyProgressBar: View {
    let progress: Double
    @State private var animated: Double = 0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(.white.opacity(0.28))
                RoundedRectangle(cornerRadius: 3)
                    .fill(.white.opacity(0.9))
                    .frame(width: geo.size.width * animated)
            }
        }
        .frame(height: 5)
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) {
                animated = progress
            }
        }
        .onChange(of: progress) { _, newValue in
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) {
                animated = newValue
            }
        }
    }
}

#Preview {
    DailyPracticeCard(viewModel: HomeViewModel())
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
