import SwiftUI

struct StageBadge: View {
    let stage: WordStage

    var body: some View {
        Text(stage.label)
            .font(AppTypography.PlusJakartaSans.caption1)
            .foregroundStyle(stage.color)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background {
                Capsule()
                    .strokeBorder(stage.color, lineWidth: 1.5)
            }
    }
}

#Preview {
    HStack(spacing: 8) {
        ForEach(WordStage.allCases, id: \.self) { StageBadge(stage: $0) }
    }
    .padding()
}
