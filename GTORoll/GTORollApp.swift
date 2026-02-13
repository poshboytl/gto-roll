import SwiftUI

@main
struct GTORollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "applewatch")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("GTORoll")
                .font(.title)
            Text("请在 Apple Watch 上使用")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
