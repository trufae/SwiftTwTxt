import SwiftUI

#if os(macOS)
import AppKit
typealias PlatformImage = NSImage
#else
import UIKit
typealias PlatformImage = UIImage
#endif

class AsyncImageLoader: ObservableObject {
    @Published var image: PlatformImage? = nil

    private var url: URL?

    func loadImage(from url: URL) {
        self.url = url
        Task {
            if let cachedImage = getCachedImage(for: url) {
                await MainActor.run { self.image = cachedImage }
            } else {
                await downloadImage(from: url)
            }
        }
    }

    private func getCachedImage(for url: URL) -> PlatformImage? {
        if let cachedData = URLCache.shared.cachedResponse(for: URLRequest(url: url))?.data {
            return PlatformImage(data: cachedData)
        }
        return nil
    }

    private func downloadImage(from url: URL) async {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let image = PlatformImage(data: data) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                await MainActor.run { self.image = image }
            }
        } catch {
            print("Failed to download image: \\(error.localizedDescription)")
        }
    }
}
