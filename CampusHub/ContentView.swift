import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var showOnboarding = true
    @State private var selectedTab = "home"

    var body: some View {
        Group {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { showSplash = true }
                        }
                    }
            } else if showOnboarding {
                OnboardingScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation { showOnboarding = true }
                        }
                    }
            } else {
                MainTabView(selectedTab: $selectedTab)
            }
        }
    }
}

struct MainTabView: View {
    @Binding var selectedTab: String

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                // Screen content
                Group {
                    switch selectedTab {
                    case "home":
                        HomeScreen()
                    case "clubs":
                        ClubsScreen()
                    case "calendar":
                        EventCalendarScreen()
                    case "bookmarks":
                        BookmarksScreen()
                    case "notifications":
                        NotificationsScreen()
                    default:
                        HomeScreen()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
