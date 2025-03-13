import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Monitorias()
                .tabItem {
                    Label("Monitorias", systemImage: "doc.richtext.fill.he")
                }
            Agua()
                .tabItem {
                    Label("Água", systemImage: "drop.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
