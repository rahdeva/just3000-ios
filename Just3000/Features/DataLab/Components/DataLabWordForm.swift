import SwiftUI

struct DataLabWordForm: View {
    @Bindable var vm: DataLabViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if vm.editingWord != nil {
                editMode
            } else {
                createMode
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    private var createMode: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Word (e.g. Ubiquitous)", text: $vm.newWordText)
                .textFieldStyle(.roundedBorder)

            TextField("Meaning (e.g. Present everywhere)", text: $vm.newWordMeaning)
                .textFieldStyle(.roundedBorder)

            Button("Create Word") { vm.createWord() }
                .buttonStyle(.borderedProminent)
                .disabled(vm.newWordText.isEmpty || vm.newWordMeaning.isEmpty)
        }
    }

    private var editMode: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Editing word", systemImage: "pencil.circle.fill")
                .font(.caption)
                .foregroundStyle(.orange)

            TextField("Word", text: $vm.editWordText)
                .textFieldStyle(.roundedBorder)

            TextField("Meaning", text: $vm.editWordMeaning)
                .textFieldStyle(.roundedBorder)

            HStack(spacing: 12) {
                Button("Update") { vm.updateWord() }
                    .buttonStyle(.borderedProminent)
                    .disabled(vm.editWordText.isEmpty || vm.editWordMeaning.isEmpty)

                Button("Cancel") { vm.cancelEditing() }
                    .buttonStyle(.bordered)
            }
        }
    }
}
