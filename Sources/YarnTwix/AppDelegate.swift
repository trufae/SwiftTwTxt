import Cocoa
import SwiftUI

@objc class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MainView()

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1000, height: 600),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered, defer: false)
        window.center()
        window.title = "YarnTwix"
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        setupMenus()
    }

    func setupMenus() {
        let mainMenu = NSMenu()
        NSApp.mainMenu = mainMenu

        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)

        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu

        let newPostMenuItem = NSMenuItem(title: "New Post", action: #selector(newPostAction(_:)), keyEquivalent: "n")
        newPostMenuItem.target = self
        appMenu.addItem(newPostMenuItem)

        appMenu.addItem(NSMenuItem.separator())

        let quitMenuItem = NSMenuItem(title: "Quit Twtxt", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appMenu.addItem(quitMenuItem)
    }

    @objc func newPostAction(_ sender: Any?) {
        NotificationCenter.default.post(name: .newPost, object: nil)
    }
}
