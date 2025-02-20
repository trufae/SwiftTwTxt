import SwiftUI
/*

struct TimelineView: View {
    let posts: [Post]
    let user: User

    var body: some View {
        List(posts.sorted(by: { $0.timestamp > $1.timestamp })) { post in
            HStack(alignment: .top) {
                if let avatarURL = user.avatar {
                    AsyncImageView(url: avatarURL)
                }
                VStack(alignment: .leading) {
                    Text(user.nick)
                        .font(.headline)
                    Text(post.message)
                        .font(.body)
                }
            }
        }
    }
}
*/

import SwiftUI

struct TimelineView: View {
    let posts: [Post]
    let user: User

    var body: some View {
        List(posts.sorted(by: { $0.timestamp > $1.timestamp })) { post in
            HStack(alignment: .top, spacing: 10) {
                AsyncImageView(url: user.avatar) // Show avatar
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading) {
                    Text(user.nick)
                        .font(.headline)
                    Text(post.message)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

/*
import SwiftUI

struct TimelineView: View {
    @StateObject var viewModel = TwtxtViewModel()
    let twtxtURL = URL(string: "https://www.radare.org/tw.txt")!

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let user = viewModel.user {
                    List(viewModel.posts) { post in
                        HStack(alignment: .top) {
                            if let avatarURL = user.avatar {
                                AsyncImageView(url: avatarURL)
                            }
                            VStack(alignment: .leading) {
                                Text(user.nick)
                                    .font(.headline)
                                Text(post.message)
                                    .font(.body)
                                    .lineLimit(nil)
                            }
                        }
                    }
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("twtxt Timeline")
            .toolbar {
                Button(action: {
                    Task {
                        await viewModel.fetchTwtxtFile(from: twtxtURL)
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .task {
                await viewModel.fetchTwtxtFile(from: twtxtURL)
            }
        }
    }
}
*/
