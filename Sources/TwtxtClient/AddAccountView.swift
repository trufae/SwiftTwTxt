import SwiftUI

struct AddAccountView: View {
    @ObservedObject var viewModel: TwtxtViewModel
    @State private var name: String = ""
    @State private var url: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Form {
                TextField("Name", text: $name)
    		    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("URL", text: $url)
    		    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }.padding()
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
