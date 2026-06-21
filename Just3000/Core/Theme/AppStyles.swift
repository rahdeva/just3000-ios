import SwiftUI

// MARK: - Playful Card Modifier

struct PlayfulCardModifier: ViewModifier {
    let backgroundColor: Color
    let borderColor: Color
    let shadowColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let shadowOffset: CGSize
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background {
                ZStack {
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(shadowColor)
                    .offset(
                        x: shadowOffset.width,
                        y: shadowOffset.height
                    )

                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(backgroundColor)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: cornerRadius,
                            style: .continuous
                        )
                        .strokeBorder(
                            borderColor,
                            lineWidth: borderWidth
                        )
                    }
                }
            }
    }
}

extension View {
    func playfulCard(
        backgroundColor: Color = .white,
        borderColor: Color = .primary,
        shadowColor: Color = .primary,
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 2,
        shadowOffset: CGSize = CGSize(width: 4, height: 4),
        horizontalPadding: CGFloat = 20,
        verticalPadding: CGFloat = 20
    ) -> some View {
        modifier(
            PlayfulCardModifier(
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                shadowColor: shadowColor,
                cornerRadius: cornerRadius,
                borderWidth: borderWidth,
                shadowOffset: shadowOffset,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding
            )
        )
    }
}
// MARK: - Playful Button Style

struct PlayfulButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let shadowColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let shadowHeight: CGFloat
    let expandsHorizontally: Bool

    init(
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        borderColor: Color = .primary,
        shadowColor: Color = .primary,
        cornerRadius: CGFloat = 22,
        borderWidth: CGFloat = 3,
        shadowHeight: CGFloat = 6,
        expandsHorizontally: Bool = true
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.shadowColor = shadowColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.shadowHeight = shadowHeight
        self.expandsHorizontally = expandsHorizontally
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(
                maxWidth: expandsHorizontally ? .infinity : nil
            )
            .background {
                ZStack {
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(shadowColor)
                    .offset(y: shadowHeight)

                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(backgroundColor)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: cornerRadius,
                            style: .continuous
                        )
                        .strokeBorder(
                            borderColor,
                            lineWidth: borderWidth
                        )
                    }
                }
            }
            .offset(
                y: configuration.isPressed ? shadowHeight : 0
            )
            .opacity(isEnabled ? 1 : 0.5)
            .animation(
                .easeOut(duration: 0.12),
                value: configuration.isPressed
            )
    }
}

extension ButtonStyle where Self == PlayfulButtonStyle {
    static var playful: PlayfulButtonStyle {
        PlayfulButtonStyle()
    }
}

// MARK: - Playful Progress Style

struct PlayfulProgressStyle: ProgressViewStyle {
    let trackColor: Color
    let progressColor: Color
    let height: CGFloat

    init(
        trackColor: Color = .black.opacity(0.2),
        progressColor: Color = .white,
        height: CGFloat = 14
    ) {
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.height = height
    }

    func makeBody(configuration: Configuration) -> some View {
        let progress = min(
            max(configuration.fractionCompleted ?? 0, 0),
            1
        )

        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)

                Capsule()
                    .fill(progressColor)
                    .frame(
                        width: geometry.size.width * progress
                    )
            }
        }
        .frame(height: height)
        .animation(
            .easeInOut(duration: 0.25),
            value: progress
        )
    }
}

extension ProgressViewStyle where Self == PlayfulProgressStyle {
    static var playful: PlayfulProgressStyle {
        PlayfulProgressStyle()
    }
}
