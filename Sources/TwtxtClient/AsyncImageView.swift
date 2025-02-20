// import SwiftUI

import SwiftUI

struct AsyncImageView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "person.crop.circle.badge.exclamationmark") // Error placeholder
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                    case .empty:
                        ProgressView() // Show loading indicator
                    @unknown default:
                        Color.gray
                    }
                }
            } else {
                Image(systemName: "person.crop.circle") // Placeholder for missing URL
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    }
}
