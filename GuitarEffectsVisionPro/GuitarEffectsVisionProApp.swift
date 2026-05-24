import SwiftUI

@main
struct GuitarEffectsVisionProApp: App {
    @StateObject private var audioEngine = AudioEngineManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioEngine)
        }
    }
}
