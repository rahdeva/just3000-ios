import SwiftUI

struct DataLabSessionForm: View {
    @Bindable var vm: DataLabViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let session = vm.currentSession {
                activeSession(session)
            } else {
                noSessionForm
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    private func activeSession(_ session: UserSession) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Session active", systemImage: "checkmark.shield.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.green)

            Group {
                sessionField(label: "Access Token", value: session.accessToken)
                if !session.refreshToken.isEmpty {
                    sessionField(label: "Refresh Token", value: session.refreshToken)
                }
                if let expiry = session.expiresAt {
                    sessionField(label: "Expires At", value: expiry.formatted(date: .abbreviated, time: .shortened))
                }
            }

            Button("Delete Session") { vm.deleteSession() }
                .buttonStyle(.bordered)
                .tint(.red)
        }
    }

    private var noSessionForm: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("No session stored", systemImage: "shield.slash")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            TextField("Access Token", text: $vm.accessToken)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            TextField("Refresh Token (optional)", text: $vm.refreshToken)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            Button("Save Session") { vm.saveSession() }
                .buttonStyle(.borderedProminent)
                .disabled(vm.accessToken.isEmpty)
        }
    }

    private func sessionField(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.caption.monospaced())
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }
}
