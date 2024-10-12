import SwiftUI
import shared

struct ContentView: View {
    @StateObject private var timezoneItems = TimezoneItems()
    var body: some View {
        // 1
        TabView {
          // 2
          TimezoneView()
             // 3
            .tabItem {
              Label("Time Zones", systemImage: "network")
            }
          // 4
          FindMeeting()
            .tabItem {
              Label("Find Meeting", systemImage: "clock")
            }
        }
        .accentColor(Color.white)
        // 5
        .environmentObject(timezoneItems)
      }

}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
