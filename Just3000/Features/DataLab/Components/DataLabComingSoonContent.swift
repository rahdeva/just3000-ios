import SwiftUI

// Shared placeholder view for storage technologies not yet implemented.
// Each coming-soon view file wraps this with its own about text and use cases.
struct DataLabComingSoonContent: View {
    let type: DataLabStorageType
    let about: String
    let useCases: [String]
    let note: String?

    init(
        type: DataLabStorageType,
        about: String,
        useCases: [String],
        note: String? = nil
    ) {
        self.type = type
        self.about = about
        self.useCases = useCases
        self.note = note
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                heroSection
                phaseBanner
                aboutSection
                useCasesSection
                if let note {
                    noteSection(note)
                }
            }
            .padding()
        }
        .navigationTitle(type.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Hero

    private var heroSection: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.accentColor.opacity(0.1))
                    .frame(width: 56, height: 56)
                Image(systemName: type.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color.accentColor)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(type.rawValue)
                    .font(.title2.bold())
                Text(type.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Phase Banner

    private var phaseBanner: some View {
        HStack(spacing: 10) {
            Image(systemName: "clock.badge")
                .foregroundStyle(.orange)
            Text("Coming in Phase \(type.phase)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.orange)
            Spacer()
            Text("Phase \(type.phase)")
                .font(.caption2.weight(.bold))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.orange.opacity(0.12))
                .foregroundStyle(.orange)
                .clipShape(Capsule())
        }
        .padding(14)
        .background(Color.orange.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - About

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("About", systemImage: "info.circle")
                .font(.headline)
            Text(about)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Use Cases

    private var useCasesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Ideal For", systemImage: "checkmark.seal")
                .font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(useCases, id: \.self) { useCase in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.subheadline)
                        Text(useCase)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Note

    private func noteSection(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .foregroundStyle(.yellow)
                .font(.subheadline)
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
