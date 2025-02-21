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
		.onAppear {
		    print("Error Message \(errorMessage)")
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
    }
}
