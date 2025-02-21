import SwiftUI

@MainActor
class TwtxtViewModel: ObservableObject {
    @Published var accounts: [User] = []
    @Published var posts: [Post] = []
    @Published var showAddAccountDialog = false
    @Published var showNewPostDialog = false
    init() {
        if let url = URL(string: "https://www.radare.org/tw.txt") {
            addAccount(name: "radare", url: url)
        }
        if let url = URL(string: "https://duque-terron.cat/twtxt.txt") {
            addAccount(name: "terron", url: url)
        }
    }

    func fetchTwtxtFile(from url: URL) async -> User? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let content = String(data: data, encoding: .utf8) {
                let (account, parsedPosts) = try parseTwtxtFile(from: content, url: url)
                posts = parsedPosts.sorted { $0.timestamp > $1.timestamp }
		return account
            }
        } catch {
            print("Failed to load twtxt file: \(error.localizedDescription)")
        }
        return nil
    }

    func addAccount(name: String, url: URL?) {
	    /*
        guard let url = url else { return }
        let newUser = User(nick: name, url: url, avatar: nil, description: nil)
        DispatchQueue.main.async {
            self.accounts.append(newUser)
        }
	*/
        guard let url = url else { return }
        Task {
            // Wait for the file to be fetched
		var newUser: User;
            if let account = await fetchTwtxtFile(from: url) {
            newUser = User(nick: name, url: url, avatar: account.avatar, description: nil)
	    } else {
            newUser = User(nick: name, url: url, avatar: nil, description: nil)
	    }
            // Now create and add the account after fetching the file
            self.accounts.append(newUser)
        }
    }
}
