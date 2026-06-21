import SwiftUI

struct PracticeView: View {
    @Binding var path: NavigationPath
    @State private var viewModel   = PracticeViewModel()
    @State private var isFlipped   = false
    @State private var cardOffset: CGFloat = 0
    @State private var cardTilt: Double    = 0
    @State private var isDragging  = false
    @State private var isExiting   = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var stampRightOpacity: Double { max(0, min(1, Double(cardOffset) / 120)) }
    private var stampLeftOpacity:  Double { max(0, min(1, Double(-cardOffset) / 120)) }

    var body: some View {
        GeometryReader { geo in
            let contentWidth = contentMaxWidth(for: geo.size.width)

            ZStack {
                Color(.appBackground).ignoresSafeArea()
                Image(AppImages.bgDotGrid)
                    .resizable(resizingMode: .tile)
                    .ignoresSafeArea()
                    .opacity(0.45)

                VStack(spacing: 0) {
                    PracticeNavBar(
                        correct: viewModel.correct,
                        total: viewModel.cards.count,
                        progressFraction: viewModel.progressFraction
                    ) { dismiss() }
                    .frame(maxWidth: contentWidth)

                    cardArea(maxWidth: contentWidth)

                    PracticeGradeButtons(
                        onDidntKnow: { advanceCard(correct: false) },
                        onKnewIt:    { advanceCard(correct: true) }
                    )
                    .padding(.horizontal, 20)
                    .frame(maxWidth: contentWidth)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }

    // MARK: - Card area

    private func contentMaxWidth(for availableWidth: CGFloat) -> CGFloat {
        horizontalSizeClass == .regular ? availableWidth / 2 : .infinity
    }

    private func cardArea(maxWidth: CGFloat) -> some View {
        GeometryReader { geo in
            let cardH = min(geo.size.height * 0.92, 470)
            let cardWidth = min(geo.size.width - 40, maxWidth)

            ZStack {
                // Peek card behind
                if viewModel.cards.indices.contains(viewModel.currentIndex + 1) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .strokeBorder(.primary.opacity(0.2), lineWidth: 2)
                        }
                        .frame(width: cardWidth, height: cardH)
                        .scaleEffect(isExiting ? 1.0 : 0.94)
                        .offset(y: isExiting ? 0 : 10)
                        .opacity(isExiting ? 1.0 : 0.6)
                        .animation(.spring(response: 0.42, dampingFraction: 0.8), value: isExiting)
                }

                // Active card
                if let card = viewModel.current {
                    ZStack {
                        PracticeCardFront(card: card, isFlipped: isFlipped, height: cardH)
                        PracticeCardBack(card: card, isFlipped: isFlipped, height: cardH)
                        PracticeStamps(rightOpacity: stampRightOpacity, leftOpacity: stampLeftOpacity)
                    }
                    .frame(width: cardWidth, height: cardH)
                    .offset(x: cardOffset)
                    .rotationEffect(.degrees(cardTilt))
                    .animation(isDragging ? nil : .spring(response: 0.3, dampingFraction: 0.8), value: cardOffset)
                    .gesture(cardDragGesture)
                    .onTapGesture {
                        if !isExiting && abs(cardOffset) < 5 { flip() }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // MARK: - Helpers

    private func flip() {
        withAnimation { isFlipped.toggle() }
    }

    private var cardDragGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                guard !isExiting else { return }
                isDragging = true
                cardOffset = value.translation.width
                cardTilt   = Double(value.translation.width) / 16.0
            }
            .onEnded { value in
                isDragging = false
                guard !isExiting else { return }
                if value.translation.width > 90 {
                    advanceCard(correct: true)
                } else if value.translation.width < -90 {
                    advanceCard(correct: false)
                } else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        cardOffset = 0; cardTilt = 0
                    }
                }
            }
    }

    private func advanceCard(correct: Bool) {
        guard !isExiting else { return }
        if correct { viewModel.correct += 1 } else { viewModel.incorrect += 1 }

        isExiting = true
        withAnimation(.easeIn(duration: 0.22)) {
            cardOffset = correct ? 520 : -520
            cardTilt   = correct ? 16 : -16
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            cardOffset = 0; cardTilt = 0
            isFlipped  = false
            isExiting  = false

            if viewModel.currentIndex + 1 >= viewModel.cards.count {
                path.append(AppRoute.practiceResult(PracticeResultData(
                    correct:   viewModel.correct,
                    incorrect: viewModel.incorrect,
                    total:     viewModel.cards.count,
                    mastered:  max(0, viewModel.correct / 3),
                    newSeen:   min(3, viewModel.correct),
                    streak:    8
                )))
            } else {
                viewModel.currentIndex += 1
            }
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
