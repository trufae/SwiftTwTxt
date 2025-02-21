import SwiftUI

struct ShowNewPostView: View {
    @ObservedObject var viewModel: TwtxtViewModel
    @State private var msg: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Form {
                TextField("Message", text: $msg)
    		    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }.padding()
        .navigationTitle("Publish New Message")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    viewModel.showNewPostDialog = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Post") {
                    // TODO: append line in home .txt and scp, honor twtxt files
                    // viewModel.addAccount(name: name, url: URL(string: url))
                    viewModel.showNewPostDialog = false
                }
            }
        }
    }
}
