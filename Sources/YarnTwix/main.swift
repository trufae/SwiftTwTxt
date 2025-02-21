import AppKit

import Cocoa
import SwiftUI


extension Notification.Name {
    static let newPost = Notification.Name("newPost")
}

_ = NSApplication.shared
NSApp.setActivationPolicy(.regular)
// Entry point for the AppKit-based application.
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()


/*

   // cli entrypoint
import Foundation
import SwiftUI
// Asynchronous entry point using `Task` in a standalone Swift script
Task {
    let url = URL(string: "https://www.radare.org/tw.txt")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let content = String(data: data, encoding: .utf8) {
            let (user, posts) = try parseTwtxtFile(from: content, url: url)
            
            print("User: \(user.nick)")
            print("Description: \(user.description ?? "No description")")
            print("Posts:")
            
            for post in posts {
                print("\(post.timestamp): \(post.message)")
            }
        }
    } catch {
        print("Error fetching twtxt file: \(error)")
    }
}

// Keep the program running to allow async tasks to complete
RunLoop.main.run()
*/
