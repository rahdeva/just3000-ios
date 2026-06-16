import SwiftUI

private let stampGreen = Color(red: 52/255,  green: 199/255, blue: 89/255)
private let stampRed   = Color(red: 255/255, green: 59/255,  blue: 48/255)

struct PracticeStamps: View {
    let rightOpacity: Double
    let leftOpacity: Double

    var body: some View {
        ZStack {
            Text("GOT IT ✓")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(stampGreen)
                .padding(.horizontal, 12).padding(.vertical, 4)
                .background(stampGreen.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(stampGreen, lineWidth: 2))
                .rotationEffect(.degrees(-14))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, 24).padding(.trailing, 22)
                .opacity(rightOpacity)
                .allowsHitTesting(false)

            Text("REVIEW ↺")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(stampRed)
                .padding(.horizontal, 12).padding(.vertical, 4)
                .background(stampRed.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(stampRed, lineWidth: 2))
                .rotationEffect(.degrees(14))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 24).padding(.leading, 22)
                .opacity(leftOpacity)
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    ZStack {
        RoundedRectangle(cornerRadius: 20).fill(.white).frame(height: 380)
        PracticeStamps(rightOpacity: 0.8, leftOpacity: 0)
    }
    .padding(20)
    .background(Color(.systemGroupedBackground))
}
