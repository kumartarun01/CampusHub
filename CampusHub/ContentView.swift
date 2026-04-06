//import SwiftUI
//
//struct ContentView: View {
//    @State private var showSplash = true
//    @State private var showOnboarding = true
//    @State private var selectedTab = "home"
//
//    var body: some View {
//        Group {
//            if showSplash {
//                SplashScreen()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            withAnimation { showSplash = true }
//                        }
//                    }
//            } else if showOnboarding {
//                OnboardingScreen()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                            withAnimation { showOnboarding = false }
//                        }
//                    }
//            } else {
//                MainTabView(selectedTab: $selectedTab)
//            }
//        }
//    }
//}
//
//struct MainTabView: View {
//    @Binding var selectedTab: String
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black.ignoresSafeArea()
//
//                // Screen content
//                Group {
//                    switch selectedTab {
//                    case "home":
//                        HomeScreen()
//                    case "clubs":
//                        ClubsScreen()
//                    case "calendar":
//                        EventCalendarScreen()
//                    case "bookmarks":
//                        BookmarksScreen()
//                    case "notifications":
//                        NotificationsScreen()
//                    default:
//                        HomeScreen()
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - Root ContentView
// ─────────────────────────────────────────────
struct ContentView: View {
    @StateObject private var store = UserProfileStore()
    @State private var showSplash  = true
    @State private var showOnboard = true

    var body: some View {
        Group {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut) { showSplash = true }
                        }
                    }
            } else if showOnboard {
                OnboardingScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            withAnimation(.easeInOut) { showOnboard = true }
                        }
                    }
            } else {
                MainTabView()
                    .environmentObject(store)
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - MainTabView
// ─────────────────────────────────────────────
struct MainTabView: View {
    @EnvironmentObject var store: UserProfileStore
    @State private var selectedTab = "home"

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()

            Group {
                switch selectedTab {
                case "home":
                    HomeFeedScreen(selectedTab: $selectedTab)
                case "clubs":
                    ClubsScreen(selectedTab: $selectedTab)
                case "calendar":
                    EventCalendarScreen(selectedTab: $selectedTab)
                case "bookmarks":
                    BookmarksScreen(selectedTab: $selectedTab)
                default:
                    ProfileScreen(selectedTab: $selectedTab)
                        .environmentObject(store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            BottomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview { ContentView() }
