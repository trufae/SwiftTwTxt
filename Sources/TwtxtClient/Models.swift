import Foundation

struct Post: Identifiable {
    let id = UUID()
    let timestamp: Date
    let message: String
    let images: [String]
}

struct User : Identifiable, Codable {

    init(id: UUID = UUID(), nick: String, url: URL, avatar: URL?, description: String?) {
        self.id = id
        self.nick = nick
        self.url = url
        self.avatar = avatar
        self.description = description
    }
    var id = UUID() // Ensures each user has a unique identifier
    var nick: String
    var url: URL
    var avatar: URL?
    var description: String?
}

func parseTwtxtFile(from content: String, url: URL) throws -> (User, [Post]) {
    var user = User(nick: "", url: url, avatar: nil, description: nil)
    var posts = [Post]()
    let lines = content.split(separator: "\n")

    // Primary ISO 8601 formatter
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    // Fallback DateFormatter (when ISO8601 fails)
    let fallbackFormatter = DateFormatter()
    fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Matches "2025-02-13T10:19:17"
    fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Assume UTC

    // Additional fallback formatter for timestamps with "Z"
    let utcFormatter = DateFormatter()
    utcFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    utcFormatter.timeZone = TimeZone(secondsFromGMT: 0)

    for line in lines {
        if line.starts(with: "#") {
            let components = line.dropFirst().split(separator: "=", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
            if components.count == 2 {
                switch components[0] {
                case "nick":
                    user.nick = components[1]
                case "avatar":
                    user.avatar = URL(string: components[1].trimmingCharacters(in: .whitespaces))
                    print(user.avatar);
                case "description":
                    user.description = components[1]
                default:
                    break
                }
            }
        } else {
            let components = line.split(separator: "\t", maxSplits: 1).map { String($0) }
            if components.count == 2 {
                let timestamp = components[0]
                    var date: Date? = isoFormatter.date(from: timestamp)

                    // Use fallback formatters if ISO 8601 parsing fails
                    if date == nil {
                        date = fallbackFormatter.date(from: timestamp)
                    }
                if date == nil {
                    date = utcFormatter.date(from: timestamp)
                }

		if let date = date {
    var message = components[1]
    var images = [String]()
    let pattern = "!\\[[^\\]]*\\]\\(([^)]+)\\)"
    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(message.startIndex..., in: message)
        let matches = regex.matches(in: message, range: range)
        for match in matches {
            if let imageRange = Range(match.range(at: 1), in: message) {
                images.append(String(message[imageRange]))
            }
        }
        message = regex.stringByReplacingMatches(in: message, range: range, withTemplate: "")
    }
    let post = Post(timestamp: date, message: message, images: images)
    posts.append(post)
}
/*

                if let date = date {
                    let post = Post(timestamp: date, message: components[1])
                        posts.append(post)
                } else {
                    print("⚠️ Failed to parse date: \(timestamp)")
                }
		*/
            }
        }
    }
    return (user, posts)
}
