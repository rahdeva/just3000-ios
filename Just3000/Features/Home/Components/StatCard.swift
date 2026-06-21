import SwiftUI

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.primary)
                .monospacedDigit()
                .padding(.top, 6)
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadowPrimary()
    }
}

#Preview {
    HStack(spacing: 12) {
        StatCard(value: "7",  label: "Day streak",  icon: "flame.fill",            color: .orange)
        StatCard(value: "14", label: "Best streak", icon: "crown.fill",            color: .purple)
        StatCard(value: "42", label: "Sessions",    icon: "checkmark.circle.fill", color: Color(red: 52/255, green: 199/255, blue: 89/255))
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
