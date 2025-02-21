import AppKit

import Cocoa
import SwiftUI

@objc class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the SwiftUI view that provides the window content.
        let contentView = MainView()

        // Create the window with a title and style.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1000, height: 600),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered, defer: false)
        window.center()
        window.title = "Twtxt" // Set window title
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        // Setup the application menu.
        setupMenus()
    }

    func setupMenus() {
        let mainMenu = NSMenu()
        NSApp.mainMenu = mainMenu

        // Application menu item (the first menu in the menu bar)
        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)

        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu

        // "New Post" menu item with cmd+N.
        let newPostMenuItem = NSMenuItem(title: "New Post", action: #selector(newPostAction(_:)), keyEquivalent: "n")
        newPostMenuItem.target = self
        appMenu.addItem(newPostMenuItem)

        // Separator for clarity.
        appMenu.addItem(NSMenuItem.separator())

        // "Quit" menu item with cmd+Q.
        let quitMenuItem = NSMenuItem(title: "Quit Twtxt", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appMenu.addItem(quitMenuItem)
    }

    @objc func newPostAction(_ sender: Any?) {
        // Post a notification that your SwiftUI MainView listens for to show the new post dialog.
        NotificationCenter.default.post(name: .newPost, object: nil)
    }
}

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
