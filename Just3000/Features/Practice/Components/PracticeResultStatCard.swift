import SwiftUI

struct PracticeResultStatCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.primary)
                .monospacedDigit()
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        PracticeResultStatCard(icon: "scope",      label: "Accuracy",   value: "80%", color: Color(red: 94/255,  green: 92/255,  blue: 230/255))
        PracticeResultStatCard(icon: "flame.fill", label: "Day streak", value: "8",   color: Color(red: 255/255, green: 149/255, blue: 0))
        PracticeResultStatCard(icon: "star.fill",  label: "Mastered",   value: "+2",  color: Color(red: 52/255,  green: 199/255, blue: 89/255))
        PracticeResultStatCard(icon: "sparkles",   label: "New words",  value: "3",   color: Color(red: 175/255, green: 82/255,  blue: 222/255))
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
