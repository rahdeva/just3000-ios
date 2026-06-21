import SwiftUI

private let confettiColors: [Color] = [
    Color(red: 94/255,  green: 92/255,  blue: 230/255),
    Color(red: 52/255,  green: 199/255, blue: 89/255),
    Color(red: 255/255, green: 149/255, blue: 0),
    Color(red: 175/255, green: 82/255,  blue: 222/255),
    .blue, .yellow,
]

struct ConfettiView: View {
    var count: Int = 50

    var body: some View {
        GeometryReader { geo in
            ForEach(0..<count, id: \.self) { i in
                ConfettiPiece(
                    color: confettiColors[i % confettiColors.count],
                    startX: CGFloat.random(in: 0...geo.size.width),
                    delay: Double(i) * 0.035
                )
            }
        }
    }
}

private struct ConfettiPiece: View {
    let color: Color
    let startX: CGFloat
    let delay: Double

    @State private var y: CGFloat = -20
    @State private var opacity: Double = 1
    @State private var rotation: Double = 0

    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: 8, height: 14)
                .rotationEffect(.degrees(rotation))
                .position(x: startX, y: y)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.4).delay(delay)) {
                        y = geo.size.height + 40
                        rotation = Double.random(in: 180...720)
                    }
                    withAnimation(.easeIn(duration: 0.5).delay(delay + 0.9)) {
                        opacity = 0
                    }
                }
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        ConfettiView(count: 50).ignoresSafeArea()
    }
}
