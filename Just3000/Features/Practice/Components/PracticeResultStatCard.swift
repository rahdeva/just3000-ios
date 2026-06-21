import SwiftUI

struct PracticeResultStatCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon)
                .font(AppTypography.PlusJakartaSans.body)
                .foregroundStyle(color)
            Text(value)
                .font(AppTypography.SFMono.title1)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Text(label)
                .font(AppTypography.PlusJakartaSans.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .playfulCard(cornerRadius: 16, borderWidth: 2, horizontalPadding: 0, verticalPadding: 0)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        PracticeResultStatCard(icon: "scope",      label: "Accuracy",   value: "80%", color: Color(.brandPrimary))
        PracticeResultStatCard(icon: "flame.fill", label: "Day streak", value: "8",   color: Color(red: 255/255, green: 149/255, blue: 0))
        PracticeResultStatCard(icon: "star.fill",  label: "Mastered",   value: "+2",  color: Color(red: 52/255,  green: 199/255, blue: 89/255))
        PracticeResultStatCard(icon: "sparkles",   label: "New words",  value: "3",   color: Color(red: 175/255, green: 82/255,  blue: 222/255))
    }
    .padding()
    .background(Color(.appBackground))
}
