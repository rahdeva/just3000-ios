import SwiftUI

struct StageBadge: View {
    let stage: WordStage

    var body: some View {
        Text(stage.label)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(stage.color)
            .padding(.vertical, 2)
            .padding(.horizontal, 7)
            .background(stage.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    HStack(spacing: 8) {
        ForEach(WordStage.allCases, id: \.self) { StageBadge(stage: $0) }
    }
    .padding()
}
