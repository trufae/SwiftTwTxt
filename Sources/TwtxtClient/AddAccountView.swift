import SwiftUI

struct AddAccountView: View {
    @ObservedObject var viewModel: TwtxtViewModel
    @State private var name: String = ""
    @State private var url: String = ""

    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("URL", text: $url)
        }
        .navigationTitle("Follow User")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    viewModel.showAddAccountDialog = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    viewModel.addAccount(name: name, url: URL(string: url))
                    viewModel.showAddAccountDialog = false
                }
            }
        }
    }
}
