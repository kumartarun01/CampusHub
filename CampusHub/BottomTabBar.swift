import SwiftUI

struct BottomTabBar: View {
    let selected: String

    struct TabItem {
        let id: String
        let icon: String
        let label: String
    }

    let tabs: [TabItem] = [
        TabItem(id: "home", icon: "house.fill", label: "Home"),
        TabItem(id: "clubs", icon: "building.columns.fill", label: "Clubs"),
        TabItem(id: "calendar", icon: "calendar", label: "Calendar"),
        TabItem(id: "bookmarks", icon: "bookmark.fill", label: "Bookmarks"),
        TabItem(id: "profile", icon: "person.fill", label: "Profile")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.id) { tab in
                Button(action: {}) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20))
                            .foregroundColor(selected == tab.id ? .white : Color(white: 0.4))
                        Text(tab.label)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(selected == tab.id ? .white : Color(white: 0.4))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Color(white: 0.06)
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Rectangle()
                        .fill(Color(white: 0.15))
                        .frame(height: 0.5),
                    alignment: .top
                )
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            Spacer()
            BottomTabBar(selected: "home")
        }
    }
}
