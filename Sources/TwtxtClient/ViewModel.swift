import SwiftUI

@MainActor
class TwtxtViewModel: ObservableObject {
    @Published var accounts: [User] = []
    @Published var posts: [Post] = []
    @Published var showAddAccountDialog = false
    init() {
	if let url = URL(string: "https://www.radare.org/tw.txt") {
            addAccount(name: "radare", url: url)
        }
	if let url = URL(string: "https://duque-terron.cat/twtxt.txt") {
            addAccount(name: "terron", url: url)
        }
    }

    func fetchTwtxtFile(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let content = String(data: data, encoding: .utf8) {
                let (_, parsedPosts) = try parseTwtxtFile(from: content, url: url)
                posts = parsedPosts.sorted { $0.timestamp > $1.timestamp }
            }
        } catch {
            print("Failed to load twtxt file: \(error.localizedDescription)")
        }
    }

    func addAccount(name: String, url: URL?) {
    guard let url = url else { return }
    let newUser = User(nick: name, url: url, avatar: nil, description: nil)
    DispatchQueue.main.async {
        self.accounts.append(newUser)
    }
}
/*

    func addAccount(name: String, url: URL?) {
        guard let url = url else { return }
        let newUser = User(nick: name, url: url, avatar: nil, description: nil)
        accounts.append(newUser)
    }
    */
}
/*
import SwiftUI

@MainActor
class TwtxtViewModel: ObservableObject {
    @Published var user: User?
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchTwtxtFile(from url: URL) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let content = String(data: data, encoding: .utf8) {
                let (parsedUser, parsedPosts) = try parseTwtxtFile(from: content, url: url)
                user = parsedUser
                posts = parsedPosts.sorted { $0.timestamp > $1.timestamp }
            }
        } catch {
            errorMessage = "Failed to load twtxt file: \(error.localizedDescription)"
        }
    }
}
*/
