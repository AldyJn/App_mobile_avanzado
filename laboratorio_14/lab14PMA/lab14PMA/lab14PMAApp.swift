import SwiftUI
import FirebaseCore

@main
struct lab14PMAApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
