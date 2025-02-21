import SwiftUI

struct TimelineView: View {
    let posts: [Post]
    let user: User

    var body: some View {
        List(posts.sorted(by: { $0.timestamp > $1.timestamp })) { post in
            HStack(alignment: .top, spacing: 10) {
                AsyncImageView(url: user.avatar) // Show avatar
                    .frame(width: 40, height: 40)
                                .clipShape(Circle())
		    VStack(alignment: .leading) {
    Text(user.nick)
        .font(.headline)
    Text(post.message)
        .font(.body)
        .foregroundColor(.primary)
    ForEach(post.images, id: \.self) { imageUrl in
        if let url = URL(string: imageUrl) {
            AsyncImageView(url: url)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}
/*
                VStack(alignment: .leading) {
                    Text(user.nick)
                        .font(.headline)
                    Text(post.message)
                        .font(.body)
                        .foregroundColor(.primary)
                }
		*/
            }
            .padding(.vertical, 4)
        }
    }
}
