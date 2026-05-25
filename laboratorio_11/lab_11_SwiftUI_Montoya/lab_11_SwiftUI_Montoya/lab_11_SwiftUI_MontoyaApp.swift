import SwiftUI
import SwiftData

@main
struct lab_11_SwiftUI_MontoyaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(ModelContainerProvider.shared.container)
        }
    }
}
