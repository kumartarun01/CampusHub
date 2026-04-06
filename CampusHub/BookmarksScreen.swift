//import SwiftUI
//
//struct BookmarksScreen: View {
//    @State private var selectedTab = "Bookmarks"
//    let tabs = ["Bookmarks", "Clubs"]
//
//    struct BookmarkItem: Identifiable {
//        let id = UUID()
//        let icon: String
//        let title: String
//        let subtitle: String
//        let isBookmarked: Bool
//    }
//
//    let bookmarks: [BookmarkItem] = [
//        BookmarkItem(icon: "bookmark.fill", title: "Tech Talk: AI", subtitle: "Apr 2 · 10da · 1sa", isBookmarked: true),
//        BookmarkItem(icon: "music.note", title: "Annual Art Exhibtion", subtitle: "Apr 15 · 6ums", isBookmarked: true),
//        BookmarkItem(icon: "music.note", title: "Music Fest", subtitle: "Apr 13 · 6ums", isBookmarked: true),
//        BookmarkItem(icon: "camera", title: "Photo Walk", subtitle: "Apr 19 · 6ahd", isBookmarked: true),
//        BookmarkItem(icon: "desktopcomputer", title: "Robotics Demo", subtitle: "Lb Jun 35 · 2025S", isBookmarked: true)
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//
//            VStack(spacing: 0) {
//                // Header
//                HStack {
//                    Text("Bookmarks")
//                        .font(.system(size: 26, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 16)
//
//                // Tab switcher
//                HStack(spacing: 10) {
//                    ForEach(tabs, id: \.self) { tab in
//                        Button(action: { selectedTab = tab }) {
//                            Text(tab)
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(selectedTab == tab ? .black : .white)
//                                .padding(.horizontal, 18)
//                                .padding(.vertical, 9)
//                                .background(selectedTab == tab ? Color.white : Color(white: 0.15))
//                                .cornerRadius(20)
//                        }
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 20)
//
//                // Bookmarks list
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 0) {
//                        ForEach(bookmarks) { item in
//                            HStack(spacing: 14) {
//                                // Icon box
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(white: 0.12))
//                                        .frame(width: 44, height: 44)
//                                    Image(systemName: item.icon)
//                                        .font(.system(size: 18))
//                                        .foregroundColor(.white)
//                                }
//
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(item.title)
//                                        .font(.system(size: 15, weight: .semibold))
//                                        .foregroundColor(.white)
//                                    HStack(spacing: 4) {
//                                        Image(systemName: "calendar")
//                                            .font(.system(size: 11))
//                                            .foregroundColor(Color(white: 0.4))
//                                        Text(item.subtitle)
//                                            .font(.system(size: 12))
//                                            .foregroundColor(Color(white: 0.4))
//                                    }
//                                }
//
//                                Spacer()
//
//                                // Bookmark icon
//                                Image(systemName: item.isBookmarked ? "bookmark.fill" : "bookmark")
//                                    .foregroundColor(Color(white: 0.5))
//                                    .font(.system(size: 16))
//                            }
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 14)
//
//                            Divider()
//                                .background(Color(white: 0.12))
//                                .padding(.horizontal, 20)
//                        }
//                    }
//                    .padding(.bottom, 100)
//                }
//            }
//
//            // Bottom Tab Bar
//            VStack {
//                Spacer()
//                BottomTabBar(selected: "bookmarks")
//            }
//        }
//    }
//}
//
//#Preview {
//    BookmarksScreen()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - BookmarksScreen
// ─────────────────────────────────────────────
struct BookmarksScreen: View {
    @Binding var selectedTab: String
    @State private var activeTab = "Bookmarks"   // internal tab — NOT the global one

    private struct Item: Identifiable {
        let id = UUID(); let icon, title, subtitle, tag: String
    }

    private let items: [Item] = [
        Item(icon: "mic.fill",         title: "Tech Talk: AI in 2025",  subtitle: "Apr 3 · 9AM · Hall A",   tag: "Free"),
        Item(icon: "music.note",       title: "Annual Art Exhibition",   subtitle: "Apr 5 · 10AM · Gallery",  tag: "Cultural"),
        Item(icon: "music.note",       title: "Music Fest",              subtitle: "Apr 13 · 6PM · Grounds",  tag: "Free"),
        Item(icon: "camera.fill",      title: "Photo Walk",              subtitle: "Apr 19 · 6AM · Campus",   tag: "Club"),
        Item(icon: "desktopcomputer",  title: "Robotics Demo",           subtitle: "Jun 30 · 2PM · Lab B",    tag: "Tech")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // Header
                HStack {
                    Text("Bookmarks")
                        .font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 16)

                // Inner tabs
                HStack(spacing: 10) {
                    ForEach(["Bookmarks","Clubs"], id: \.self) { t in
                        Button { activeTab = t } label: {
                            Text(t)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(activeTab == t ? .black : .white)
                                .padding(.horizontal, 18).padding(.vertical, 9)
                                .background(activeTab == t ? Color.white : Color(white: 0.15))
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.bottom, 20)

                // Content
                if activeTab == "Bookmarks" {
                    bookmarksList
                } else {
                    clubsPlaceholder
                }
            }
        }
    }

    var bookmarksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(items) { item in
                    HStack(spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(white: 0.12)).frame(width: 44, height: 44)
                            Image(systemName: item.icon)
                                .font(.system(size: 18)).foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                            HStack(spacing: 4) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 11)).foregroundColor(Color(white: 0.4))
                                Text(item.subtitle)
                                    .font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                            }
                        }
                        Spacer()

                        Text(item.tag)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(white: 0.55))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(Color(white: 0.12)).cornerRadius(6)

                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.white).font(.system(size: 15))
                    }
                    .padding(.horizontal, 20).padding(.vertical, 14)
                    Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 110)
        }
    }

    var clubsPlaceholder: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "person.3")
                .font(.system(size: 48)).foregroundColor(Color(white: 0.2))
            Text("No saved clubs")
                .font(.system(size: 17, weight: .semibold)).foregroundColor(Color(white: 0.4))
            Text("Follow clubs to see them here.")
                .font(.system(size: 14)).foregroundColor(Color(white: 0.28))
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    struct Wrap: View {
        @State var tab = "bookmarks"
        var body: some View { BookmarksScreen(selectedTab: $tab) }
    }
    return Wrap()
}
