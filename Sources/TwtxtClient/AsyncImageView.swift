import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    @Published var errorMessage: String? = nil

    func load(from url: URL) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load image: \(error.localizedDescription)"
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Invalid image data"
                    }
                    return
                }

                DispatchQueue.main.async {
                    #if os(macOS)
                    if let nsImage = NSImage(data: data) {
                        self.image = Image(nsImage: nsImage)
                    } else {
                        self.errorMessage = "Failed to decode NSImage"
                    }
                    #else
                    if let uiImage = UIImage(data: data) {
                        self.image = Image(uiImage: uiImage)
                    } else {
                        self.errorMessage = "Failed to decode UIImage"
                    }
                    #endif
                }
            }.resume()
        }
    }
}

struct AsyncImageView: View {
    let url: URL?
    @StateObject private var loader = ImageLoader()

    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if let errorMessage = loader.errorMessage {
                VStack {
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            } else if let url = url {
                ProgressView()
                    .onAppear {
                        print("Loading image from: \(url.absoluteString)")
                        loader.load(from: url)
                    }
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        // .frame(width: 40, height: 40)
    }
}

/*

struct AsyncImageView: View {
    let url: URL?
    @StateObject private var loader = AsyncImageLoader()

    var body: some View {
        Group {
            if let image = loader.image {
                Image(nsImage: image) // Use nsImage for macOS compatibility
                    .resizable()
                    .scaledToFit()
            } else if let url = url {
                ProgressView()
                    .onAppear { loader.loadImage(from: url) }
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 40, height: 40)
    }
}

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
*/
