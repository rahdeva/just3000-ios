import SwiftUI
import UIKit

/*
     Default Dynamic Type base sizes:

     Large Title : 34 pt
     Title 1     : 28 pt
     Title 2     : 22 pt
     Title 3     : 20 pt
     Headline    : 17 pt
     Body        : 17 pt
     Callout     : 16 pt
     Subheadline : 15 pt
     Footnote    : 13 pt
     Caption 1   : 12 pt
     Caption 2   : 11 pt

     Notes:
     - Title 1 maps to Font.TextStyle.title.
     - Caption 1 maps to Font.TextStyle.caption.
     - Custom fonts scale with the user's Dynamic Type settings.
 */

/*
    Example:
         Text("Good Morning!")
             .font(AppTypography.Outfit.largeTitle)

         Text("Master the 3,000 most common words.")
             .font(AppTypography.PlusJakartaSans.body)

         Text("421 / 3000")
             .font(AppTypography.SFMono.headline)
 */

enum AppTypography {

    // MARK: - Outfit

    /// Used for display text, headings, and prominent numbers.
    enum Outfit {

        static let largeTitle = AppTypography.customFont(
            FontName.Outfit.bold,
            style: .largeTitle,
            fallbackWeight: .bold
        )

        static let title1 = AppTypography.customFont(
            FontName.Outfit.bold,
            style: .title1,
            fallbackWeight: .bold
        )

        static let title2 = AppTypography.customFont(
            FontName.Outfit.semiBold,
            style: .title2,
            fallbackWeight: .semibold
        )

        static let title3 = AppTypography.customFont(
            FontName.Outfit.semiBold,
            style: .title3,
            fallbackWeight: .semibold
        )

        static let headline = AppTypography.customFont(
            FontName.Outfit.semiBold,
            style: .headline,
            fallbackWeight: .semibold
        )

        static let body = AppTypography.customFont(
            FontName.Outfit.regular,
            style: .body,
            fallbackWeight: .regular
        )

        static let callout = AppTypography.customFont(
            FontName.Outfit.medium,
            style: .callout,
            fallbackWeight: .medium
        )

        static let subheadline = AppTypography.customFont(
            FontName.Outfit.regular,
            style: .subheadline,
            fallbackWeight: .regular
        )

        static let footnote = AppTypography.customFont(
            FontName.Outfit.regular,
            style: .footnote,
            fallbackWeight: .regular
        )

        static let caption1 = AppTypography.customFont(
            FontName.Outfit.medium,
            style: .caption1,
            fallbackWeight: .medium
        )

        static let caption2 = AppTypography.customFont(
            FontName.Outfit.medium,
            style: .caption2,
            fallbackWeight: .medium
        )
    }

    // MARK: - Plus Jakarta Sans

    /// Used for body text, labels, buttons, and general UI content.
    enum PlusJakartaSans {

        static let largeTitle = AppTypography.customFont(
            FontName.PlusJakartaSans.bold,
            style: .largeTitle,
            fallbackWeight: .bold
        )

        static let title1 = AppTypography.customFont(
            FontName.PlusJakartaSans.bold,
            style: .title1,
            fallbackWeight: .bold
        )

        static let title2 = AppTypography.customFont(
            FontName.PlusJakartaSans.semiBold,
            style: .title2,
            fallbackWeight: .semibold
        )

        static let title3 = AppTypography.customFont(
            FontName.PlusJakartaSans.semiBold,
            style: .title3,
            fallbackWeight: .semibold
        )

        static let headline = AppTypography.customFont(
            FontName.PlusJakartaSans.semiBold,
            style: .headline,
            fallbackWeight: .semibold
        )

        static let body = AppTypography.customFont(
            FontName.PlusJakartaSans.regular,
            style: .body,
            fallbackWeight: .regular
        )

        static let callout = AppTypography.customFont(
            FontName.PlusJakartaSans.medium,
            style: .callout,
            fallbackWeight: .medium
        )

        static let subheadline = AppTypography.customFont(
            FontName.PlusJakartaSans.regular,
            style: .subheadline,
            fallbackWeight: .regular
        )

        static let footnote = AppTypography.customFont(
            FontName.PlusJakartaSans.regular,
            style: .footnote,
            fallbackWeight: .regular
        )

        static let caption1 = AppTypography.customFont(
            FontName.PlusJakartaSans.medium,
            style: .caption1,
            fallbackWeight: .medium
        )

        static let caption2 = AppTypography.customFont(
            FontName.PlusJakartaSans.medium,
            style: .caption2,
            fallbackWeight: .medium
        )
    }

    // MARK: - SF Mono

    /// Used for ranks, statistics, codes, and technical numbers.
    enum SFMono {

        static let largeTitle = AppTypography.monospacedFont(
            style: .largeTitle,
            weight: .bold
        )

        static let title1 = AppTypography.monospacedFont(
            style: .title1,
            weight: .bold
        )

        static let title2 = AppTypography.monospacedFont(
            style: .title2,
            weight: .bold
        )

        static let title3 = AppTypography.monospacedFont(
            style: .title3,
            weight: .semibold
        )

        static let headline = AppTypography.monospacedFont(
            style: .headline,
            weight: .semibold
        )

        static let body = AppTypography.monospacedFont(
            style: .body,
            weight: .regular
        )

        static let callout = AppTypography.monospacedFont(
            style: .callout,
            weight: .regular
        )

        static let subheadline = AppTypography.monospacedFont(
            style: .subheadline,
            weight: .regular
        )

        static let footnote = AppTypography.monospacedFont(
            style: .footnote,
            weight: .regular
        )

        static let caption1 = AppTypography.monospacedFont(
            style: .caption1,
            weight: .regular
        )

        static let caption2 = AppTypography.monospacedFont(
            style: .caption2,
            weight: .regular
        )
    }
}

// MARK: - Typography Style

private extension AppTypography {

    enum TypographyStyle {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case body
        case callout
        case subheadline
        case footnote
        case caption1
        case caption2

        var size: CGFloat {
            switch self {
                case .largeTitle:
                    34
                case .title1:
                    28
                case .title2:
                    22
                case .title3:
                    20
                case .headline, .body:
                    17
                case .callout:
                    16
                case .subheadline:
                    15
                case .footnote:
                    13
                case .caption1:
                    12
                case .caption2:
                    11
            }
        }

        var textStyle: Font.TextStyle {
            switch self {
                case .largeTitle:
                    .largeTitle
                case .title1:
                    .title
                case .title2:
                    .title2
                case .title3:
                    .title3
                case .headline:
                    .headline
                case .body:
                    .body
                case .callout:
                    .callout
                case .subheadline:
                    .subheadline
                case .footnote:
                    .footnote
                case .caption1:
                    .caption
                case .caption2:
                    .caption2
            }
        }
    }
}

// MARK: - Font Names

private extension AppTypography {

    enum FontName {

        enum Outfit {
            static let regular = "Outfit-Regular"
            static let medium = "Outfit-Medium"
            static let semiBold = "Outfit-SemiBold"
            static let bold = "Outfit-Bold"
        }

        enum PlusJakartaSans {
            static let regular = "PlusJakartaSans-Regular"
            static let medium = "PlusJakartaSans-Medium"
            static let semiBold = "PlusJakartaSans-SemiBold"
            static let bold = "PlusJakartaSans-Bold"
        }
    }
}

// MARK: - Font Builders

private extension AppTypography {

    static func customFont(
        _ name: String,
        style: TypographyStyle,
        fallbackWeight: Font.Weight
    ) -> Font {
        guard UIFont(name: name, size: style.size) != nil else {
            return .system(
                style.textStyle,
                design: .default,
                weight: fallbackWeight
            )
        }

        return .custom(
            name,
            size: style.size,
            relativeTo: style.textStyle
        )
    }

    static func monospacedFont(
        style: TypographyStyle,
        weight: Font.Weight
    ) -> Font {
        .system(
            style.textStyle,
            design: .monospaced,
            weight: weight
        )
    }
}
