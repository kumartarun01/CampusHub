import SwiftUI

struct BookmarksScreen: View {
    @State private var selectedTab = "Bookmarks"
    let tabs = ["Bookmarks", "Clubs"]

    struct BookmarkItem: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let subtitle: String
        let isBookmarked: Bool
    }

    let bookmarks: [BookmarkItem] = [
        BookmarkItem(icon: "bookmark.fill", title: "Tech Talk: AI", subtitle: "Apr 2 · 10da · 1sa", isBookmarked: true),
        BookmarkItem(icon: "music.note", title: "Annual Art Exhibtion", subtitle: "Apr 15 · 6ums", isBookmarked: true),
        BookmarkItem(icon: "music.note", title: "Music Fest", subtitle: "Apr 13 · 6ums", isBookmarked: true),
        BookmarkItem(icon: "camera", title: "Photo Walk", subtitle: "Apr 19 · 6ahd", isBookmarked: true),
        BookmarkItem(icon: "desktopcomputer", title: "Robotics Demo", subtitle: "Lb Jun 35 · 2025S", isBookmarked: true)
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Bookmarks")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)

                // Tab switcher
                HStack(spacing: 10) {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: { selectedTab = tab }) {
                            Text(tab)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(selectedTab == tab ? .black : .white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 9)
                                .background(selectedTab == tab ? Color.white : Color(white: 0.15))
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Bookmarks list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(bookmarks) { item in
                            HStack(spacing: 14) {
                                // Icon box
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(white: 0.12))
                                        .frame(width: 44, height: 44)
                                    Image(systemName: item.icon)
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                    HStack(spacing: 4) {
                                        Image(systemName: "calendar")
                                            .font(.system(size: 11))
                                            .foregroundColor(Color(white: 0.4))
                                        Text(item.subtitle)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(white: 0.4))
                                    }
                                }

                                Spacer()

                                // Bookmark icon
                                Image(systemName: item.isBookmarked ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(Color(white: 0.5))
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)

                            Divider()
                                .background(Color(white: 0.12))
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }

            // Bottom Tab Bar
            VStack {
                Spacer()
                BottomTabBar(selected: "bookmarks")
            }
        }
    }
}

#Preview {
    BookmarksScreen()
}
